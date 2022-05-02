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

  def certificate?
    # can view his certificate and everybody if and  if he viewed all course lesoon
    # user viewed lesson == course lesson count
   @record.course.lessons.count == @record.course.checked_lessons.where(user: @record.user).count
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
