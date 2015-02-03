class Application::Base < ApplicationController
  before_action :authenticate_user!

  helper_method :current_user

  layout 'application'

  protected

  def current_user
    @current_user ||= User.find(params[:user_id])
  end

  def companies
    @companies = current_user.companies
  end

  def selected_company
    session[:selected_company] = companies.first if companies
    @selected_company = session[:selected_company]
  end

  private

  def default_url_options
    { user_id: params[:user_id] }
  end
end