class Lesson < ApplicationRecord
  belongs_to :course
  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  #converting the public record to title string
  def to_s
    title
  end
  

end
