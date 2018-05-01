class RenameActionTableToDemandTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :actions, :demands
  end
end
