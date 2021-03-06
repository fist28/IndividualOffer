class Application::Base < ApplicationController
  before_action :authenticate_user!
  before_action :selected_company
  before_action :companies

  helper_method :current_user

  layout 'application'

  protected

  def current_user
    @current_user ||= User.find(params[:user_id])
  end

  def companies
    @companies ||= current_user.companies
  end

  def selected_company
    @selected_company = company || current_user.companies.find_by(id: session[:selected_company])
  end

  def company
    @company ||= current_user.companies.find_by(id: params[:company_id] || params[:id])
    session[:selected_company] = @company.id if @company && !@company.id.nil?
    @company
  end

  def client
    @client ||= selected_company.clients.find_by(id: params[:client_id] || params[:id], company_id: selected_company)
  end

  def clients
    @clients ||= selected_company.clients
  end

  def products
    @products ||= selected_company.products
  end

  def categories
    @categories ||= selected_company.categories
  end

  private

  def default_url_options
    { user_id: params[:user_id] }
  end
end