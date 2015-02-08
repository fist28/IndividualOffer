class Clients::Base < Application::Base

  def client
    @client ||= @selected_company.clients.find(params[:client_id])
  end

end