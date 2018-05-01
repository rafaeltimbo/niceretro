class AddForeignKeyToTables < ActiveRecord::Migration[5.0]
  def change
    add_index :topics, :retrospective_id
    add_index :actions, :retrospective_id
    add_index :doubts, :retrospective_id
  end
end
