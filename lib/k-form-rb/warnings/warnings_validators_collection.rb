module KFormRb
  module Warnings

    # this module is supposed to be included in the ActiveRecord::Base class
    module WarningValidatorsCollection

      def self.included(klass)
        # by default validators are
        # * stored in the _validators class attribute
        # * triggered by the `validate` callback
        #
        # we duplicate this logic for the warnings
        klass.class_attribute :_warning_validators, instance_writer: false, default: Hash.new { |h, k| h[k] = [] }
        klass.define_callbacks :validate_warnings, scope: [:name]
        klass.define_callbacks :validation_warnings, scope: [:name]
        klass.extend ClassMethods
      end


      module ClassMethods
        # List all warning validators of the model
        # duplicate logic from `validators` method
        # https://github.com/rails/rails/blob/v6.1.4.1/activemodel/lib/active_model/validations.rb#L192
        def warning_validators
          _warning_validators.values.flatten.uniq
        end

        # this is the class method that allows to define warnings validations
        #
        # in order to do this, simply encapsulate any validation inside a `warnings` block
        #
        #     class MyModel < ActiveRecord::Base
        #       # classic validations (blocks save)
        #       validates_presence_of :title
        #
        #       warnings do
        #         # warnings validation (does not block save)
        #         validates_presence_of :description
        #       end
        #
        # implementation details:
        # * the `warnings` method temporarily overrides some methods in order to
        #   capture validations declarations and store them into separate collections
        # * in this way errors validations and warnings validations can be manipulated
        #   separately
        # * the following methods impacted
        #   * `_validators` will temporarely point to `_warning_validators`
        #   * `set_callback` calls for the :validate callback will actually call the
        #     `set_callback` method for the :validate_warnings callback

        def warnings
          # store initial methods
          _validators_original = singleton_class.instance_method(:_validators)
          set_callback_original = singleton_class.instance_method(:set_callback)

          # temporarily override the `_validators` method
          singleton_class.define_method(:_validators) do
            _warning_validators
          end

          # temporarily override the `set_callback` method for :validate callback
          singleton_class.define_method(:set_callback) do |name, *filter_list, &block|
            _super = set_callback_original.bind(self)

            case name.to_sym
            when :validate
              _super.call(:validate_warnings, *filter_list, &block)
            when :validation
              _super.call(:validation_warnings, *filter_list, &block)
            else
              _super.call(name, *filter_list, &block)
            end
          end

          # run the block => all warnings validations declared in the block will be
          # stored separately from the error validations
          yield if block_given?

        ensure
          # restore the initial methods
          singleton_class.define_method(_validators_original.name, _validators_original)
          singleton_class.define_method(set_callback_original.name, set_callback_original)
        end
      end



    end
  end
end