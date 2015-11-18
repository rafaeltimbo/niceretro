class CreateRetrospectives < ActiveRecord::Migration
  def change
    create_table :retrospectives do |t|
      t.string :title
      t.datetime :date
      t.integer :room

      t.timestamps null: false
    end
  end
end
