class Team < ActiveRecord::Base
  validates :name, presence: true

  has_many :retrospectives
  has_many :demands
  has_many :doubts
end
