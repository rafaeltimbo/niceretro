class Doubt < ActiveRecord::Base
  belongs_to :team
  belongs_to :retrospective
end
