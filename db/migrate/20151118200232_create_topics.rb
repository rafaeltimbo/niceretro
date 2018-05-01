class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.text :description
      t.string :type
      t.integer :retrospective_id

      t.timestamps null: false
    end
  end
end
