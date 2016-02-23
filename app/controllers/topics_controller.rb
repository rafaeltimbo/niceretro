class TopicsController < ApplicationController
  def like
    @topic = Topic.find(params[:id])
    @topic.improve_like
  end

  def dislike
    @topic = Topic.find(params[:id])
    @topic.improve_dislike
  end
end
