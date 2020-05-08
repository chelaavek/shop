class Ability
  include CanCan::Ability

  def initialize(admin_user)
    # Define abilities for the passed in user here. For example:
    #
       admin_user ||= AdminUser.new
       if admin_user.role=="admin"
         can :manage, :all
         can :update, :all
       elsif admin_user.role=="user"
         can :read, :all
         cannot :manage, Product
         can :create, Order
         can :read, Order
         can :update, Order
         can :destroy, Order
         can :create, Cart
         can :read, Cart
         can :update, Cart
         can :destroy, Cart
       elsif admin_user.role=='banned'
         cannot :read, :all
         cannot :create, :all
         cannot :destroy, :all
         cannot :update, :all
       else
         can :create, Order
         can :read, Order
         can :update, Order
         can :destroy, Order
       end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
