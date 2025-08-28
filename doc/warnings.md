## ⚠️ Warnings messages validations

With k-form-rb we have created a system to create warning messages `KFormRb::Warnings::Validator`, similar to the way
ruby on rails works with error handling.
But the purpose of these warnings is to put an information message on a form without blocking the user from submitting the form.

The warnings validation helper adds warnings to a model, as opposed to errors. Warnings allow the model to be saved, but
also provide feedback to the user that certain attributes did not meet specific criteria. This feedback can be helpful
in some cases to improve the quality of the data.

The following are the methods and callbacks associated with the usage of warnings:

1. `warnings do`: A block that encloses the validations to be executed as warnings. The warnings can be specified with
   the same validation helpers that are used for errors.

```ruby
warnings do
  validates_length_of :title, minimum: 10
end
```

2. `instance.warnings`: A method that returns the warnings associated with an instance of a model.

````ruby
instance.valid?
instance.warnings.full_messages
````

## Using Warning callback and is executed on (before | after) validations errors

3. `before_warning_validation`: A callback that is executed before the warnings are validated.

```ruby
before_warning_validation :set_before_warning_validation_accessor
```

4. `after_warning_validation`: A callback that is executed after the warnings are validated.

```ruby
after_warning_validation :set_after_warning_validation_accessor
```

## Using Warning callback and is executed on before (create | save)

5. `before_save`: A callback that is executed before the model is saved.

```ruby
before_save :set_before_save_accessor
```

6. `before_create`: A callback that is executed before the model is created.

```ruby
before_create :set_before_create_accessor
```

## Using Warning callback and is executed on after (create | save | commit)

7. `after_create`: A callback that is executed after the model is created.

````ruby
after_create :set_after_create_accessor
````

8. `after_save`: A callback that is executed after the model is saved.

````ruby
after_save :set_after_save_accessor
````

9. `after_commit`: A callback that is executed after the transaction has been committed.

````ruby
after_commit :set_after_commit_accessor
````

Warnings are a useful tool in providing feedback to the user without preventing the saving of a model. By using warnings
judiciously, models can be made more robust and user-friendly.