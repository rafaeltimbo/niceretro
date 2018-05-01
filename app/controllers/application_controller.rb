class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_team

  if ENV['HTTP_BASIC_NAME'] && ENV['HTTP_BASIC_PASS']
    http_basic_authenticate_with(
      name: ENV['HTTP_BASIC_NAME'],
      password: ENV['HTTP_BASIC_PASS']
    )
  end

  def current_team
    Team.find(params[:team_id]) if params[:team_id].present?
  end
end
