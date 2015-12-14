class RenameActionTableToDemandTable < ActiveRecord::Migration
  def change
    rename_table :actions, :demands
  end
end
