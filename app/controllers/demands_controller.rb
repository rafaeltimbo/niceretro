class DemandsController < ApplicationController
  respond_to :html, :js

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found', status: 404
  end

  def create
    @retrospective = retrospective
    @demand = @retrospective.demands.build(demands_params.merge(team: current_team))
    @demand.save
  end

  def destroy
    @demand = current_team.demands.find(params[:id])
    @demand.destroy
  end

  def edit
    @retrospective = retrospective
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

  def retrospective
    current_team.retrospectives.find(params[:retrospective_id])
  end
end
