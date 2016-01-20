class NegativeTopicsController < ApplicationController
  include RemoteFormErrorsHelper

  before_action :retrospective_id
  respond_to :html, :js

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found', status: 404
  end

  def create
    @retrospective = Retrospective.find(@retrospective_id)
    @negative_topic = @retrospective.negative_topics.build(negative_topics_params)
    @negative_topic.save
  end

  def destroy
    @negative_topic = NegativeTopic.find(params[:id])
    @negative_topic.destroy
  end

  def edit
    @retrospective = Retrospective.find(@retrospective_id)
    @negative_topic = NegativeTopic.find(params[:id])
  end

  def update
    @negative_topic = NegativeTopic.find(params[:id])
    @negative_topic.update_attributes(negative_topics_params)
  end

  private

  def negative_topics_params
    params.require(:negative_topic).permit(:description)
  end

  def retrospective_id
    @retrospective_id = params[:retrospective_id]
  end
end
