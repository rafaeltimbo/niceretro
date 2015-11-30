class NegativeTopicsController < ApplicationController
  before_action :get_retrospective_id

  def create
    @retrospective = Retrospective.find(@retrospective_id)
    @negative_topic = @retrospective.negative_topics.build(negative_topics_params)

    if @negative_topic.save
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  def destroy
    @negative_topic = PositiveTopic.find(params[:id])
    @negative_topic.destroy

    if @negative_topic.destroyed?
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  private

  def negative_topics_params
    params.require(:negative_topic).permit(:description)
  end

  def get_retrospective_id
    @retrospective_id = params[:retrospective_id]
  end
end
