class Lesson < ApplicationRecord
  belongs_to :course, counter_cache: true
  #to update your count_cache(sub) run this in console
  # Course.find_each {|course| Course.reset_counters(course.id, :lessons )}
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :content
  validates :title, :content, presence: true
  validates :content, length: {minimum: 10 }
  has_many :user_lessons, dependent: :destroy

  include RankedModel
  ranks :row_order, with_same: :course_id  


  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  #converting the public record to title string
  def to_s
    title
  end
  scope :recent_lessons, -> {order(created_at: :desc)}

  def lesson_viewed?(user)
    self.user_lessons.where(user_id: user).present?
  end
  
end
