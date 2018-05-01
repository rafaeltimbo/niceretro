class SetDefaultValueForLikeColumnsOnTopics < ActiveRecord::Migration[5.0]
  def change
    change_column :topics, :like, :integer, default: 0
    change_column :topics, :dislike, :integer, default: 0
  end
end
