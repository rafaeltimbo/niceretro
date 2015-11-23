class RetrospectiveController < ApplicationController
  def index
    @retrospectives = Retrospective.all
  end

  def new
  end
end
