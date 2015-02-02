class Application::Base < ApplicationController
  before_action :authenticate_user!

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(params[:user_id])
  end
end