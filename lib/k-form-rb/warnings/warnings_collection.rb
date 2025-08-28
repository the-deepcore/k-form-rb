module KFormRb
  module Warnings

    # this module is supposed to be included in the ActiveModel::Validations module
    # (or a class containing this module)
    # https://github.com/rails/rails/blob/v6.1.4.1/activemodel/lib/active_model/validations.rb
    module WarningCollection

      def self.included(klass)
        #klass.class_attribute :_warning_validators, instance_writer: false, default: Hash.new { |h, k| h[k] = [] }
        #klass.define_callbacks :validate_warnings, scope: [:name]
        # we need to keep the warnings in a separate object from the original errors

        klass.define_callbacks :validation_warning,
                         skip_after_callbacks_if_terminated: true,
                         scope: [:kind, :name]

        # the implementation is largely inspired from
        # https://github.com/rails/rails/blob/v6.1.4.1/activemodel/lib/active_model/validations.rb#L301
        klass.define_method :warnings do
          @warnings ||= ActiveModel::Errors.new(self)
        end


        # override the original Active Model valid? method
        # https://github.com/rails/rails/blob/v6.1.4.1/activemodel/lib/active_model/validations.rb#L334
        klass.define_method :active_model_valid? do |context = nil|
          current_context, self.validation_context = validation_context, context

          ### STEP 0 - clear previous errors and warnings
          errors.clear
          warnings.clear

          ### STEP 1 - run errors validations (and before/after callbacks)
          result =  run_validations!

          ### STEP 2 - setup what we need to setup in order to run the validation wornings
          # => override the `errors` method to that it points to the `warnings`
          def self.errors
            warnings
          end

          ### STEP 3 - run the warning validations
          _run_validation_warnings_callbacks { _run_validate_warnings_callbacks }

          ### STEP 4 - restore the original `errors` implementation (aka revert STEP 2)
          # https://github.com/rails/rails/blob/v6.1.4.1/activemodel/lib/active_model/validations.rb#L301

          def self.errors
            @errors ||= ActiveModel::Errors.new(self)
          end

          ### STEP 5 - continue with the original flow and return what the initial method was supposed to return
          result
        ensure
          self.validation_context = current_context
        end

        # override the original Active Record valid? method
        # https://github.com/rails/rails/blob/v6.1.4.1/activerecord/lib/active_record/validations.rb#L66
        klass.define_method :valid? do |context = nil|
          context ||= default_validation_context
          output = active_model_valid?(context)
          errors.empty? && output
        end
      end

    end
  end
end