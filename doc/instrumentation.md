## Usage
To use the instrumentations we must first create the file if it does not exist `app_name/config/instrumentation.rb`, then we must import the gem `require 'k-form-rb/lib/instrumentation_utils'`.
For example, to instrument the creation life cycle of your model, you can define the following method in your model class:

> "⚠️ Be careful when updating the code in the `instrumentation.rb` file. We must restart the server to apply the changes."

In this example let's assume that we have a `Car` model and that we wish after the creation of a new car to add the brand we will have a code that will look like the code below

```ruby
KFormRb::Lib::InstrumentationUtils.subscribe('botyglot.car.create') do |event|
  car = Car.find(event.payload[:id])
  car.update_attribute(:brand, "Botyglot Supercar")
end
```

## Life cycle
Here are the life cycles we have access to

Create
```ruby
  KFormRb::Lib::InstrumentationUtils.subscribe('botyglot.model_name.create')
```

Update
```ruby
  KFormRb::Lib::InstrumentationUtils.subscribe('botyglot.model_name.update')
```

Destroy
```ruby
  KFormRb::Lib::InstrumentationUtils.subscribe('botyglot.model_name.destroy')
```

When we use the instrumentation we get in response the payload of the event as below:
```ruby
payload = event.payload
record_id = event.payload[:id]
model_attributes = event.payload[:attributes]
model_class = event.payload[:class]
```

