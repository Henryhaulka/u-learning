class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
    # User.find_each {|user|User.reset_counters(user.id, :comments )}
  belongs_to :lesson, counter_cache: true
  # Lesson.find_each {|lesson|Lesson.reset_counters(lesson.id, :comments )}
  validates :content, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  # def to_s
  #   content
  # end
  
end
