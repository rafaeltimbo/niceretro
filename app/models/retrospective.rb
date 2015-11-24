class Retrospective < ActiveRecord::Base
  has_many :actions
  has_many :doubts
  has_many :negative_topics
  has_many :positive_topics
end
