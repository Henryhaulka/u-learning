class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  def edit?
    #only admin and holder of record(course.user_id) i.e teacher that owns, not any teacher
     @record.course.user == user
  end

  def show?
    user.has_role?(:admin) or user == record.course.user or  record.course.user_subscribed?(user) == true
  end
  

  def new?
  #  user == record.course.user 
  end

  def create?
    user == record.course.user
  end

  def update?
    user == record.user 
  end

  def destroy?
    user.has_role?(:admin) or user == record.course.user 
  end
end
