class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

   def index?
    user.has_role?(:admin)
  end
  def edit?
     @record.user == user
  end

  # def show?
  #   user.has_role?(:admin) or user == record.user 
  # end
  

  def update?
    user == record.user 
  end

  def destroy?
    user.has_role?(:admin)
  end
end
