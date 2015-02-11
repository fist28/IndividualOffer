class Clients::OffersController < Clients::Base
  before_action :client
  before_action :set_offer, only: [:edit, :update, :destroy]
  before_action :products
  before_action :categories

  def index
   @offers = @client.offers
  end

  def show
    @offer = @client.offers.includes(:product_offers, products: :category).find(params[:id])
  end

  def new
    @offer = @client.offers.new
    build_new_product_offers
  end

  def edit
    @offer = @client.offers.joins(product_offers: { product: :category }).find(params[:id])
    build_update_product_offers
  end

  def create
    @offer = @client.offers.new(offer_params)
    respond_to do |format|
      if @offer.save
        format.html { redirect_to company_client_offer_path(client_id: @client, id: @offer), notice: 'Offer was successfully created.' }
      else
        build_new_product_offers
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to company_client_offer_path(client_id: @client, id: @offer), notice: 'Offer was successfully updated.' }
      else
        build_update_product_offers
        format.html { render :edit }
      end
    end
  end

  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to company_client_offers_path(client_id: @client), notice: 'Offer was successfully destroyed.' }
    end
  end

  private
  def build_new_product_offers
    po = []
    @products.map { |e| po << {product_id: e.id, offer_id: @offer.id}}
    @offer.product_offers.build(po)
  end

  def build_update_product_offers
    po = []
    @products.where.not(id: @offer.products).map { |e| po << {product_id: e.id, offer_id: @offer.id}}
    @offer.product_offers.build(po)
  end

  def set_offer
    @offer = @client.offers.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:comment, product_offers_attributes: [:id, :product_id, :value, :kind, :_destroy])
  end
end
