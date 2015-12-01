class ActionsController < ApplicationController
  before_action :get_retrospective_id

  def create
    @retrospective = Retrospective.find(@retrospective_id)
    @action = @retrospective.actions.build(actions_params)

    if @action.save
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  def destroy
    @action = action.find(params[:id])
    @action.destroy

    if @action.destroyed?
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  private

  def actions_params
    binding.pry
    params.require(:action).permit(:description, :user, :status)
  end

  def get_retrospective_id
    @retrospective_id = params[:retrospective_id]
  end
end
