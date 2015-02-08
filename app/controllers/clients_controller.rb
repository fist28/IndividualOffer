class ClientsController < CompaniesBase
  # authorize_resource :class => "Company", :through => :current_user
  before_action :selected_company
  def index
    @clients = @selected_company.clients.includes(:offers)
  end
end