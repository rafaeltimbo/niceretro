class RetrospectivesController < ApplicationController
  def index
    @retrospectives = Retrospective.all
  end

  def new
    @retrospective = Retrospective.new
  end

  def create
    @retrospective = Retrospective.new(retrospectives_params)

    if @retrospective.save
      redirect_to :action => :index
    end
  end

  def destroy
    @retrospective = Retrospective.find(params[:id])
    @retrospective.destroy

    if @retrospective.destroyed?
      redirect_to :action => :index
    end
  end

  private

  def retrospectives_params
    params.require(:retrospective).permit(:title, :date, :room)
  end
end
