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
    binding.pry
    @team = Team.new(teams_params)
    @team.save
  end

  private

  def teams_params
    params.require(:team).permit(:name)
  end
end
