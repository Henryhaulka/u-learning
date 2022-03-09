class Subscription < ApplicationRecord
  belongs_to :course
  belongs_to :user
  validates :user, :course, presence: true

  #this code ensures that a user subcribe to a course only once
  # hence can't subcribe to same course twice 
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id
  scope :pending_review, -> { where(rating: [0,nil, ""], review: [0,nil, ""])}
  
  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s
    user.username + "| "  + course.title
  end
  validate :cant_subscribe_to_own_course
  protected

  def cant_subscribe_to_own_course
    if self.new_record?
          if  self.user_id == self.course.user.id
              errors.add(:base, "You can't subscribe to your own course")
          end
    end
  end
  
end
