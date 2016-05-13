class AddTeamIdToTables < ActiveRecord::Migration
  def change
    add_reference :demands, :team, index: true
    add_reference :doubts, :team, index: true
    add_reference :topics, :team, index: true
    add_reference :retrospectives, :team, index: true
  end
end
