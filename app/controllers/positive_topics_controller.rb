class PositiveTopicsController < ApplicationController
  include RemoteFormErrorsHelper

  respond_to :js

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found', status: 404
  end

  def create
    @retrospective = retrospective
    @positive_topic = @retrospective.positive_topics.build(positive_topics_params.merge(team: current_team))
    @positive_topic.save
  end

  def destroy
    @retrospective = retrospective
    @positive_topic = @retrospective.positive_topics.find(params[:id])
    @positive_topic.destroy
  end

  def edit
    @retrospective = retrospective
    @positive_topic = @retrospective.positive_topics.find(params[:id])
  end

  def update
    @retrospective = retrospective
    @positive_topic = @retrospective.positive_topics.find(params[:id])
    @positive_topic.update_attributes(positive_topics_params)
  end

  private

  def positive_topics_params
    params.require(:positive_topic).permit(:description)
  end

  def retrospective
    current_team.retrospectives.find(params[:retrospective_id])
  end
end
