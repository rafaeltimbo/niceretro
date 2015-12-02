class DemandsController < ApplicationController
  before_action :get_retrospective_id

  def create
    @retrospective = Retrospective.find(@retrospective_id)
    @demand = @retrospective.demands.build(demands_params)

    if @demand.save
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  def destroy
    @demand = Demand.find(params[:id])
    @demand.destroy

    if @demand.destroyed?
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  private

  def demands_params
    params.require(:demand).permit(:description, :user, :status)
  end

  def get_retrospective_id
    @retrospective_id = params[:retrospective_id]
  end
end
