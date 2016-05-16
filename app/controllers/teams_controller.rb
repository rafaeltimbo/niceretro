class TeamsController < ApplicationController
  respond_to :js, :html

  def index
    @teams = Team.all
    render layout: "pre_panel"
  end

  def new
    @team = Team.new
  end
end
