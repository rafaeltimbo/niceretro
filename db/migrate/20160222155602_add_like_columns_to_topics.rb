class AddLikeColumnsToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :like, :integer
    add_column :topics, :dislike, :integer
  end
end
