class RetrospectivesController < ApplicationController
  def index
    @retrospectives = Retrospective.all
  end

  def new
    @retrospective = Retrospective.new
  end

  def create
    @retrospective = Retrospective.new(retrospectives_params)

    if @retrospective.save
      redirect_to retrospectives_path
    end
  end

  def edit
    @retrospective = Retrospective.find(params[:id])
  end

  def update
    @retrospective = Retrospective.find(params[:id])
    if @retrospective.update_attributes(retrospectives_params)
      redirect_to retrospectives_path
    else
      render :edit
    end
  end

  def destroy
    @retrospective = Retrospective.find(params[:id])
    @retrospective.destroy

    if @retrospective.destroyed?
      redirect_to retrospectives_path
    end
  end

  def show
    @retrospective = Retrospective.find(params[:id])

    #Doubts
    @doubts = @retrospective.doubts
    @doubt = Doubt.new

    #Positive Topics
    @positive_topics = @retrospective.positive_topics
    @positive_topic = PositiveTopic.new

    #Negative Topics
    @negative_topics = @retrospective.negative_topics
    @negative_topic = NegativeTopic.new
  end

  private

  def retrospectives_params
    params.require(:retrospective).permit(:title, :date, :room)
  end
end
