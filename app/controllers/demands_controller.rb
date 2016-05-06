class DemandsController < ApplicationController
  before_action :get_retrospective_id
  respond_to :html, :js

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found', status: 404
  end

  def create
    @retrospective = current_team.retrospectives.find(@retrospective_id)
    @demand = @retrospective.demands.build(demands_params.merge(team: current_team))
    @demand.save
  end

  def destroy
    @demand = current_team.demands.find(params[:id])
    @demand.destroy
  end

  def edit
    @demand = current_team.demands.find(params[:id])
  end

  def update
    @demand = current_team.demands.find(params[:id])
    @demand.update_attributes(demands_params)
  end

  def update_status
    @demand = current_team.demands.find(params[:id])
    @demand.status = !@demand.status
    @demand.status ? @demand.resolved_at = Date.today : @demand.resolved_at = nil
    @demand.save
  end

  private

  def demands_params
    params.require(:demand).permit(:description, :user, :status)
  end

  def get_retrospective_id
    @retrospective_id = params[:retrospective_id]
  end
end
