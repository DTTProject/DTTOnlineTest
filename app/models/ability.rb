class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can [:edit, :update], User, id: user.id
      can [:create, :read, :update], Test, user_id: user.id
      can [:read, :create], Question, user_id: user.id
    end
  end
end
