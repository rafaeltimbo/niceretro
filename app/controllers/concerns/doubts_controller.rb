class DoubtsController < ApplicationController
  before_action :get_retrospective_id

  def create
    @retrospective = Retrospective.find(@retrospective_id)
    @doubt = @retrospective.doubts.build(doubts_params)

    if @doubt.save
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  def destroy
    @doubt = Doubt.find(params[:id])
    @doubt.destroy

    if @doubt.destroyed?
      redirect_to retrospective_path(@retrospective_id)
    end
  end

  private

  def doubts_params
    params.require(:doubt).permit(:description)
  end

  def get_retrospective_id
    @retrospective_id = params[:retrospective_id]
  end
end
