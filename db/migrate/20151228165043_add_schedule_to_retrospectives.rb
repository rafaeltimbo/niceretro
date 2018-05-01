class AddScheduleToRetrospectives < ActiveRecord::Migration[5.0]
  def change
    add_column :retrospectives, :schedule, :time
  end
end
