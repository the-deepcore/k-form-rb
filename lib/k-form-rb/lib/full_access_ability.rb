require 'cancancan'
module KFormRb
  module Lib
    class FullAccessAbility
      include ::CanCan::Ability

      def initialize(user)
        can :manage, :all
      end
    end
  end
end
