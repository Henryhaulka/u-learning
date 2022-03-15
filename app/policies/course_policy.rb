class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  def edit?
    #only admin and holder of record(course.user_id) i.e teacher that owns, not any teacher
    @user.has_role?(:admin) || @record.user == @user
  end

  def new?
   @user.has_role?(:teacher) 
  end

  def create?
    @user.has_role?(:teacher)
  end

  def update?
    @user.has_role?(:admin) or @user == record.user 
  end

  def destroy?
    @user.has_role?(:admin) or @user == @record.user 
  end

  def owner?
    user == record.user
  end

  def approve_policy?
    @user.has_role?(:admin)
  end
end
