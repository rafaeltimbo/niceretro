class SetDefaultValueForLikeColumnsOnTopics < ActiveRecord::Migration
  def change
    change_column :topics, :like, :integer, default: 0
    change_column :topics, :dislike, :integer, default: 0
  end
end
