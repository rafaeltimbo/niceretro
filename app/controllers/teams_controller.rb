class TeamsController < ApplicationController
  respond_to :js, :html

  def index
    @teams = Team.all
    render layout: "pre_panel"
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(teams_params)
    @team.save
    @config = Config.new(configs_params)
    @config.save
  end

  private

  def teams_params
    params.require(:team).permit(:name)
  end

  def configs_params
    params.require(:team).permit(:name).merge(team_id: @team.id)
  end
end
