class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, User if user.has_role?(:admin)

    can :manage, Channel if user.has_role?(:admin)
    can :approve, Channel do |channel|
    	( (not channel.is_active?) && (not channel.is_inactive?) && user.has_role?(:admin) ) || \
    	( (not channel.is_active?) && (not channel.is_inactive?) && user.has_role?(:moderator, channel) )
    end if user.has_role?(:global_moderator)

    can :edit, Channel do |channel|
    	user.has_role? :moderator, channel
    end

  	can :read, Channel do |channel|
      user.has_role?(:admin) or \
      ( channel.is_private? and channel.users.include? user)
    end

    can :manage, Quote if user.has_role?(:admin)
    can :read, Quote do |quote|
      user.has_role?(:admin) or \
      ( quote.channel.is_private? and quote.channel.users.include? user)
    end
  	can [:enable, :disable], Quote, owner_id: user.id

    can [ :enable, :disable ], Quote do |quote|
      quote.owner == user
    end

    can :create, Quote if user.id != nil
    can [:edit, :update], Quote do |quote|
      quote.owner == user
    end

  	can :create, Like if user.id != nil
  	can :create, Dislike if user.id != nil

    can :claim, Nickname do |nickname|
      nickname.is_claimable?
    end

    can :revert, Nickname do |nickname|
      nickname.is_revertable? and ( user.has_role?(:moderator,@channel) or user.has_role?(:admin) )
    end
    can :manage, Comment
  end
end
