# Errors messages

Sometimes generated error messages by Ruby on Rails don't make sense. For instance

```ruby
validates_acceptance_of :accepted_terms, :message => 'Please accept the terms of service'
```

We can avoid this by usins a small trick that we call this trick the magic hat. 

## The magic hat  🪄🎩

What is the magic hat trick ? It's refers to prepending  the carat character `^` to any error messages for which we want avoid 
displaying the name of the field when displaying the validation messages.

example:

```ruby
class MyModel < ApplicationRecord
# We add a validation on the name field so that it is present provided that true
  validates :name, presence: true, if: :conditional_method

  def conditional_method
    errors.add(:name, "^Here is a specific message for this field") if true
  end
end
```

Here is the difference with the magic hat:
<br />
`Here is a specific message for the field`

and without the magic hat:
<br />
`Name Here is a specific message for the field`


This method of not displaying the field name works on validation errors and warnings and can also be used in locales like the following example:

```yaml
en:
  activerecord:
    errors:
      models:
        item:
          attributes:
            name:
              blank: "^You can't create an item without a name."
```
