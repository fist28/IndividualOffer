class DashboardController < Application::Base
  before_action :current_user

  def index
    @companies = current_user.companies
    session[:selected_company] = @companies.first if @companies
    @selected_company = session[:selected_company]
  end
end
