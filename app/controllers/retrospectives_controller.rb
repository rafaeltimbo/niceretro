class RetrospectivesController < ApplicationController
  def index
    @retrospectives = Retrospective.where(team: current_team).order(date: :desc)
    @next_retrospective = Retrospective.where(team: current_team).next
  end

  def new
    @retrospective = Retrospective.new(team: current_team)
  end

  def create
    @retrospective = Retrospective.new(retrospectives_params.merge(team: current_team))

    if @retrospective.save
      redirect_to team_retrospectives_path(current_team)
    end
  end

  def edit
    @retrospective = current_team.retrospectives.find(params[:id])
  end

  def update
    @retrospective = current_team.retrospectives.find(params[:id])
    if @retrospective.update_attributes(retrospectives_params)
      redirect_to team_retrospectives_path(current_team)
    else
      render :edit
    end
  end

  def destroy
    @retrospective = current_team.retrospectives.find(params[:id])
    @retrospective.destroy

    if @retrospective.destroyed?
      redirect_to team_retrospectives_path(current_team)
    end
  end

  def show
    @retrospective = current_team.retrospectives.find(params[:id])
    @latest_demands = Demand.latest_demands(@retrospective)
    @is_enabled = @retrospective.is_enabled?
    demands
    doubts
    positive_topics
    negative_topics
  end

  private

  def demands
    @demands = @retrospective.demands.order(:id)
    @demand = Demand.new
  end

  def doubts
    @doubts = @retrospective.doubts.order(:id)
    @doubt = Doubt.new
  end

  def positive_topics
    @positive_topics = @retrospective.positive_topics.order(:id)
    @positive_topic = PositiveTopic.new
  end

  def negative_topics
    @negative_topics = @retrospective.negative_topics.order(:id)
    @negative_topic = NegativeTopic.new
  end

  def retrospectives_params
    params.require(:retrospective).permit(:title, :date, :room, :schedule)
  end
end
