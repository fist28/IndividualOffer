class CompanyController < Application::Base
  before_action :client

  def show

  end

  private

  def client
    @client ||= Company.find_by(id: params[:id], company_id: selected_company)
  end
end
