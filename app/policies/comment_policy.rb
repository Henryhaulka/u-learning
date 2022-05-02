class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  def edit?
    #only admin and holder of record(course.user_id) i.e teacher that owns, not any teacher
     @record.user == user
  end
  
  def update?
    #only admin and holder of record(course.user_id) i.e teacher that owns, not any teacher
     @record.user == user
  end


  def destroy?
    user.has_role?(:admin) or user == record.user 
  end
end
