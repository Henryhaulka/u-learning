class Subscription < ApplicationRecord
  belongs_to :course
  belongs_to :user
  validates :user, :course, presence: true

  #this code ensures that a user subcribe to a course only once
  # hence can't subcribe to same course twice 
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id

  validate :cant_subscribe_to_own_course

  def to_s
    user.username + "| "  + course.title
  end
  
  protected
  def cant_subscribe_to_own_course
      if self.user_id == course.user_id
        errors.add(:base, "You can't subscribe to your own course")
      end
  end
  
end
