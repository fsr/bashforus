class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, Channel if user.has_role?(:admin)
    can :approve, Channel do |channel|
    	( (not channel.is_active?) && (not channel.is_inactive?) && user.has_role?(:admin) ) || \
    	( (not channel.is_active?) && (not channel.is_inactive?) && user.has_role?(:moderator, channel) )
    end if user.has_role?(:global_moderator)

    can :edit, Channel do |channel|
    	user.has_role? :moderator, channel
    end
	can :read, Channel

    can :manage, Quote if user.has_role?(:admin)
	can :read, Quote
	can [:enable, :disable], Quote, owner_id: user.id

	can :manage, User if user.has_role?(:admin)
  end
end
