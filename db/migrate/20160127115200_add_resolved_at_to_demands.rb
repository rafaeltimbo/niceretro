class AddResolvedAtToDemands < ActiveRecord::Migration
  def change
    add_column :demands, :resolved_at, :datetime
  end
end
