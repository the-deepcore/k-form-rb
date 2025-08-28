module KFormRb
  module Warnings

    # this module is supposed to be included in the ActiveModel::Validator class
    # https://github.com/rails/rails/blob/v6.1.4.1/activemodel/lib/active_model/validator.rb#L96
    module Validator

      # when running the custom `validate_warnings` callback
      # each warning validator will be called with the methode `validate_warnings`
      # instead of `validate`
      #
      # therefore we define a new method `validate_warnings` that will simply call
      # the `original` validate
      def validate_warnings(record)

        # validate method declaration https://github.com/rails/rails/blob/v6.1.4.1/activemodel/lib/active_model/validator.rb#L122
        validate(record)
      end
    end
  end
end