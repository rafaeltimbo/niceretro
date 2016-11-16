class Team < ActiveRecord::Base
  has_many :retrospectives
  has_many :demands
  has_one :configs
end
