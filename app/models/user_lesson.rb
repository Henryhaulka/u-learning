class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  
  #To checks that a user checked a lesson once 
  validates_uniqueness_of :user_id, scope: :lesson_id
  validates_uniqueness_of :lesson_id, scope: :user_id
end
