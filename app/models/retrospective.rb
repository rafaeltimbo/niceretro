class Retrospective < ActiveRecord::Base
  has_many :demands, dependent: :destroy
  has_many :doubts, dependent: :destroy
  has_many :negative_topics
  has_many :positive_topics
end
