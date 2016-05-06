class DoubtsController < ApplicationController
  respond_to :html, :js

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render 'not_found', status: 404
  end

  def create
    @retrospective = retrospective
    @doubt = @retrospective.doubts.build(doubts_params.merge(team: current_team))
    @doubt.save
  end

  def destroy
    @doubt = retrospective.doubts.find(params[:id])
    @doubt.destroy
  end

  def edit
    @retrospective = retrospective
    @doubt = @retrospective.doubts.find(params[:id])
  end

  def update
    @doubt = retrospective.doubts.find(params[:id])
    @doubt.update_attributes(doubts_params)
  end

  private

  def doubts_params
    params.require(:doubt).permit(:description)
  end

  def retrospective
    current_team.retrospectives.find(params[:retrospective_id])
  end
end
