class AddTeamIdToConfigsTable < ActiveRecord::Migration[5.0]
  def change
    add_reference :configs, :team, index: true
  end
end
