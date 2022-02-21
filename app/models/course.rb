class Course < ApplicationRecord
    validates :title,:short_description,:price,:level,:language, presence: true
    validates :description,presence: true, length: {minimum: 5}
    has_rich_text :description
    belongs_to :user
    extend FriendlyId
    friendly_id :title, use: :slugged

    LANGUAGES = [ :English, :French, :Spanish, :Russian]
    def self.languages
        LANGUAGES.each {|language| language}
    end

    LEVELS = [ :Beginner, :Intermediate, :Advanced]
    def self.levels
        LEVELS.each {|level| level}
    end
    
end
