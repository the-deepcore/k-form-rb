require_relative '../lib/bool'
module KFormRb
  module Types
    class BoolType < ActiveRecord::Type::Boolean
      def cast(raw_value)
        super(Lib::Bool.to_bool(raw_value))
      end
    end
  end
end
