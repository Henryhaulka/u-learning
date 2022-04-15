class CourseTag < ApplicationRecord
  belongs_to :course
  # count a tag as you create a coursetag = counter_cache
  belongs_to :tag, counter_cache: true
end
