  module KFormRb
  module Concerns
    module TrackWhoMadeTheChangesConcern
      extend ActiveSupport::Concern

      # Evaluate given block in context of base class, so that
      # you can write class macros here.
      included do |base|
        before_create :set_created_by
        before_save :set_updated_by # create + update
      end

      # Define class methods from given block.
      # You can define private class methods as well.
      class_methods do
      end

      # Add instance methods (including actions) below this line.
      # You can define private instance methods as well.

      def set_created_by
        if self.respond_to?(:created_by_id)
          self.created_by ||= Current.user
        end
      end

      def set_updated_by
        if self.respond_to?(:updated_by_id)
          self.updated_by ||= Current.user
        end
      end
    end
  end
end