class ClientsController < Application::Base
  before_action :client
  def index
    @clients = @selected_company.clients.includes(:offers)
  end

  def show
    @last_offer = @client.offers.last

  end

  def edit

  end

  def update
    respond_to do |format|
      if @client.update(product_params)
        format.html { redirect_to company_client_path(id: @client), notice: 'Client was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def product_params
    params.require(:company).permit(:name, :nip, :address, :city, :post_code, :description, :contact)
  end

end