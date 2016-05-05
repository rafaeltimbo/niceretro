class Retrospective < ActiveRecord::Base
  belongs_to :team

  has_many :demands
  has_many :doubts, dependent: :destroy
  has_many :negative_topics, dependent: :destroy
  has_many :positive_topics, dependent: :destroy

  scope :next, -> { order(date: :desc).first }

  def is_enabled?
    self == team.retrospectives.next
  end
end
