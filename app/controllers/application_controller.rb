class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    application_path(current_user)
  end

  def index
    if current_user.companies.blank?
      redirect_to new_company_path
    else
      if session[:selected_company] && session[:selected_company].in?(current_user.companies)
        redirect_to company_clients_path
      else
        # index - choose selected_company
        session[:selected_company] = current_user.companies.first.id
        redirect_to company_clients_path(company_id: session[:selected_company])
      end
    end
  end
end