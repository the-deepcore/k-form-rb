module KFormRb
  module Concerns
    module InstrumentationConcern
      extend ActiveSupport::Concern

      # Evaluate given block in context of base class, so that
      # you can write class macros here.
      included do |base|

        after_commit :instrument_create, on: :create
        after_commit :instrument_update, on: :update
        after_commit :instrument_destroy, on: :destroy

      end

      # Define class methods from given block.
      # You can define private class methods as well.
      class_methods do
      end

      # Add instance methods (including actions) below this line.
      # You can define private instance methods as well.

      def instrument_create
        instrument_record_lifecyle("create")
      end

      def instrument_update
        instrument_record_lifecyle("update")
      end

      def instrument_destroy
        instrument_record_lifecyle("destroy")
      end

      def instrument_record_lifecyle(action, payload = {})
        default_payload = {
          id: self.id,
          class: self.class.name,
          attributes: self.attributes,
          changes: self.previous_changes
        }

        model_key = self.class.model_name.i18n_key

        ActiveSupport::Notifications.instrument "botyglot.#{model_key}.#{action}", default_payload.merge(payload)
      end
    end
  end
end