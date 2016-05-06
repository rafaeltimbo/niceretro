class DoubtsController < ApplicationController
  before_action :retrospective_id
  respond_to :html, :js

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found', status: 404
  end

  def create
    @retrospective = current_team.retrospectives.find(@retrospective_id)
    @doubt = @retrospective.doubts.build(doubts_params.merge(team: current_team))
    @doubt.save
  end

  def destroy
    @doubt = current_team.doubts.find(params[:id])
    @doubt.destroy
  end

  def edit
    @retrospective = current_team.retrospectives.find(@retrospective_id)
    @doubt = current_team.doubts.find(params[:id])
  end

  def update
    @doubt = current_team.doubts.find(params[:id])
    @doubt.update_attributes(doubts_params)
  end

  private

  def doubts_params
    params.require(:doubt).permit(:description)
  end

  def retrospective_id
    @retrospective_id = params[:retrospective_id]
  end
end
