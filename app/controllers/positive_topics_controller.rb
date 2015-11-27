class PositiveTopicsController < ApplicationController
  before_action :get_retrospective_id

  def create
    @retrospective = Retrospective.find(@retrospective_id)
    @positive_topic = @retrospective.positive_topics.build(positive_topics_params)

    if @positive_topic.save
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  def destroy
    @positive_topic = PositiveTopic.find(params[:id])
    @positive_topic.destroy

    if @positive_topic.destroyed?
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  private

  def positive_topics_params
    params.require(:positive_topic).permit(:description)
  end

  def get_retrospective_id
    @retrospective_id = params[:retrospective_id]
  end
end
