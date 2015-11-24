class AddForeignKeyToTables < ActiveRecord::Migration
  def change
    add_index :topics, :retrospective_id
    add_index :actions, :retrospective_id
    add_index :doubts, :retrospective_id
  end
end
