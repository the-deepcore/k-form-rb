module KFormRb
  module Concerns
    module UtilsConcern
      extend ActiveSupport::Concern

      # Evaluate given block in context of base class, so that
      # you can write class macros here.
      included do |base|

      end

      # Define class methods from given block.
      # You can define private class methods as well.
      class_methods do
        def hidrate(model_or_id)
          model_or_id.is_a?(self) ? model_or_id : self.find(model_or_id)
        end
      end

      # Add instance methods (including actions) below this line.
      # You can define private instance methods as well.

    end
  end
end