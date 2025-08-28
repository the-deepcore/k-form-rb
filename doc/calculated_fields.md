# Calculated Fields

## Calculated attributes on `ActiveRecord::Base` instances

There are cases where we need to calculate results and store the value in the database to query it later.

One could achieve this by using the following code pattern:

````ruby
# the following model has 2 attributes that are persisted in the database
# * quantity_in_metric_tons : user editable field via a form
# * quantity_in_kilograms : calculated field
class Order < ActiveRecord::Base
  
  before_save :set_quantity_in_kilograms
  
  def calculate_quantity_in_kilograms
    quantity_in_metric_tons * 1000 if quantity_in_metric_tons.present?
  end
  
  def set_quantity_in_kilograms
    self.quantity_in_kilograms = calculate_quantity_in_kilograms
  end
end
````

This pattern can be quite verbose when we have multiple calculated attributes. We can simplify this:

````ruby
class Order < ActiveRecord::Base
  
  include KFormRb::CalculatedFields::CoreConcern
  
  before_save :set_quantity_in_kilograms
  
  calculate_attribute :quantity_in_kilograms do
    # self is the instance object
    quantity_in_metric_tons * 1000 if quantity_in_metric_tons.present?
  end
end
````

It might not seem too impressive, but this approach has several advantages:
* it will automatically define the methods `calculate_<attribute name>` and  `set_<attribute name>`
* it will make sure that the attribute (in our case, `quantity_in_kilograms`) *always* returns the correct value,
  by recalculating it
* it will check for naming conflicts and raise errors when this occurs 


As a rule of thumb, the block passed to the `calculate_attribute`:
* should only return the expected result  
* should not trigger any save in the database
* could use memoization to avoid unnecessary calculations 
* cannot take any arguments

The `calculate_attribute` can be used with both persisted attributes, like in the example above, or virtual attributes, 
like the ones generated with `attr_accesor`.

### Testing

The fact that calculated fields are always calculated can be challenging when testing. There are several options that you 
could use

#### 1) Disable automatic all calculations at instance level 

Use the `disable_automatic_calculations` virtual attribute to disable all calculations (you can call 
the `set_<attribute name>`  when you want to recalculate the value of an calculated attribute)

````ruby 
instance.disable_automatic_calculations = true
````

#### 2) Mocking to `calculate_<attribute name>` 

In some tests you might need to force the value a calculated attribute. If it's too complicated to setup the test data
to achieve that, then you have the option of mocking the `calculate_<attribute name>` and forcing it to return the 
value you need.

## Calculated attributes on `ActiveRecord::Relation` collections

It is also possible to calculate attributes on `ActiveRecord::Relation` (aka calculated attributes on scopes), making it
possible to calculated values based on the results of the scope (model instances).

````ruby
class Order < ActiveRecord::Base
  
  include KFormRb::CalculatedFields::CoreConcern
  
  calculate_attribute :total_quantity_in_kilograms, on: :collection do
    # self is an ActiveRecord::Relations
    reduce(0) {|sum, instance| sum + instance.quantity_in_metric_tons * 1000}
  end

  scope :today, -> { where(arel_table[created_at].gteq(Time.current.beginning_of_day))}
end
````

Now we can easily get the total quantity based on *any* scope:

````ruby
  Order.total_quantity_in_kilograms
  Order.today.total_quantity_in_kilograms
````

There are several important differences when defining a calculated attribute on collections compared to a calculated
attribute on an instance:
* collection calculated attributes are never persisted (  `set_<attribute name>` and `calculate_<attribute name>`
  methods are not generated)
* the block passed to the calculated_attribute method accepts arguments
* cannot use memoization (because a new ActiveRecord::Relation object is created each time the calculated attribute is called )

### Useful calculated attributes on collections

This gem also provides common functions that could be used on any `ActiveRecord::Relation` scope via 
the `include KFormRb::CalculatedFields::CollectionFunctionsConcern`

#### reduce_sum_prod(*attributes)

Returns the sum product of attributes passed as argument over the entire scope
At least one attribute is required. 

For instance, if we have a `Model` with the fields `field_a`, `field_b` and the scope on which we want to
calculate the sum product has the following results:

    { field_a: 1, field_b: 10}
    { field_a: 2, field_b: 20} <
    { field_a: 3, field_b: 30}

==>  `some_scope.reduce_sum_prod(:field_a, :field_b)` will return `140` (1* 10 + 2 * 20 + 3 * 30) 

#### calculate_attribute :reduce_sum(attribute)

Returns the sum of the attribute passed ad argument over the entire scope

==> `some_scope.reduce_sum(:field_b)` will return `60` (10 + 20 + 30) 

Note: While  `sum` (method provided by rails) only works with persisted attributes, `reduce_sum` also works with virtual fields.

#### reduce_weighted_average(averaged_attribute, weight_attribute)

Returns the weighed average of two attributes

==> `some_scope.reduce_weighted_average(:field_a, :field_b)` will return `2.(3)` ( (1* 10 + 2 * 20 + 3 * 30) / (10 + 20 + 30) )