class Ability
  include ::CanCan::Ability
  attr_reader :user

  def initialize(current_user)
    @user = current_user
    alias_action :create, :read, :update, :destroy, to: :crud

    # TODO: set abilities
    # ex: set_abilities_for_user(current_user)
  end

  def set_abilities_for_users(current_user)
  end
end