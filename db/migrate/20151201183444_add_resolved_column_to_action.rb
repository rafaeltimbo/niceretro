class AddResolvedColumnToAction < ActiveRecord::Migration
  def change
    add_column :actions, :resolved, :boolean
  end
end
