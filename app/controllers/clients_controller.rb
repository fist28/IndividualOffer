class ClientsController < Application::Base
  before_action :client, except: [:new, :create]
  def index
    @clients = @selected_company.clients.includes(:offers)
  end

  def show
    @last_offer = @client.offers.last
  end

  def new
    @client = @selected_company.clients.new
  end

  def create
    @client = @selected_company.clients.new(company_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to company_clients_path, notice: 'Client was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @client.update(company_params)
        format.html { redirect_to company_client_path(id: @client), notice: 'Client was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to company_clients_path, notice: 'Client was successfully destroyed.' }
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :nip, :address, :city, :post_code, :description, :contact)
  end

end