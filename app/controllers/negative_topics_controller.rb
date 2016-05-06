class NegativeTopicsController < ApplicationController
  include RemoteFormErrorsHelper

  respond_to :html, :js

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found', status: 404
  end

  def create
    @retrospective = retrospective
    @negative_topic = @retrospective.negative_topics
                        .build(negative_topics_params.merge(team: current_team))
    @negative_topic.save
  end

  def destroy
    @negative_topic = retrospective.negative_topics.find(params[:id])
    @negative_topic.destroy
  end

  def edit
    @retrospective = retrospective
    @negative_topic = @retrospective.negative_topics.find(params[:id])
  end

  def update
    @negative_topic = retrospective.negative_topics.find(params[:id])
    @negative_topic.update_attributes(negative_topics_params)
  end

  private

  def negative_topics_params
    params.require(:negative_topic).permit(:description)
  end

  def retrospective
    current_team.retrospectives.find(params[:retrospective_id])
  end
end
