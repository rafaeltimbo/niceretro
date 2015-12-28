class AddScheduleToRetrospectives < ActiveRecord::Migration
  def change
    add_column :retrospectives, :schedule, :time
  end
end
