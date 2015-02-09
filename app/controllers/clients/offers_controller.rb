class Clients::OffersController < Clients::Base
  before_action :set_offer, only: [:edit, :update, :destroy]
  before_action :client
  before_action :products
  before_action :categories

  # GET /offers
  # GET /offers.json
  def index
   @offers = @client.offers
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = @client.offers.includes(products: :category).find(params[:id])
  end

  # GET /offers/new
  def new
    @offer = @client.offers.new
    @offer.product_offers.build
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = @client.offers.new(offer_params)
    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = @client.offers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:comment, product_offers_attributes: [:product_id, :value, :kind])
    end
end
