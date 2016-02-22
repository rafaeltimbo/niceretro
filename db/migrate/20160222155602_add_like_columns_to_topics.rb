class AddLikeColumnsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :like, :integer
    add_column :topics, :dislike, :integer
  end
end
