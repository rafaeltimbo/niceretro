class CreateDoubts < ActiveRecord::Migration[5.0]
  def change
    create_table :doubts do |t|
      t.text :description
      t.integer :retrospective_id

      t.timestamps null: false
    end
  end
end
