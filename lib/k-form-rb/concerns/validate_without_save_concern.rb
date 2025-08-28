module KFormRb
  module Concerns
    module ValidateWithoutSaveConcern
      extend ActiveSupport::Concern

      included do
        after_save :force_rollback!, if: :_prevent_save
      end

      # define a virtual attribute named _prevent_save
      # that is compatible with the all common bool values

      def _prevent_save
        @_prevent_save
      end

      def _prevent_save=(value)
        @_prevent_save = KFormRb::Lib::Bool.to_bool(value)
      end

      private

      def force_rollback!
        raise ActiveRecord::Rollback.new("_prevent_save")
      end
    end
  end
end
