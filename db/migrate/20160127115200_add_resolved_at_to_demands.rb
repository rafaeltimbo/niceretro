class AddResolvedAtToDemands < ActiveRecord::Migration[5.0]
  def change
    add_column :demands, :resolved_at, :datetime
  end
end
