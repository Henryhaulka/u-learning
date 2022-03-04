class Course < ApplicationRecord
    validates :title,:short_description,:price,:level,:language, presence: true
    validates :description,presence: true, length: {minimum: 5}
    has_rich_text :description
    belongs_to :user
    has_many :lessons
    
    extend FriendlyId
    friendly_id :title, use: :slugged
    scope :recent, -> {order(created_at: :desc)}
    scope :limiter, -> {limit(3)}
    
    LANGUAGES = [ :English, :French, :Spanish, :Russian]
    def self.languages
        LANGUAGES.each {|language| language}
    end

    LEVELS = [ :Beginner, :Intermediate, :Advanced]
    def self.levels
        LEVELS.each {|level| level}
    end
    
    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }
end
