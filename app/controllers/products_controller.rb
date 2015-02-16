class ProductsController < Application::Base
  before_action :products
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :categories, only: [:edit, :new]

  def index
    @products = products.includes(:category)
  end

  def show
    @company_query =  Company.select('companies.name, companies.id, offers.id as offer_id, product_offers.value, product_offers.kind').joins(offers: :products).where('products.id = ? AND products.company_id = ?', @product, @selected_company)
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = @selected_company.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
    end
  end

  def async_calculate_change_price
    respond_to do |format|
      format.json do
        product = @products.find(params[:product_id])
        new_netto, new_brutto = product.calculate_change_price(params[:change_value], params[:change_kind])
        request = { json: {status: :ok, new_netto: new_netto, new_brutto: new_brutto}, content_type: 'text/javascript' }
        render request
      end
      format.any do
        request = { json: {status: 400}, content_type: 'text/javascript' }
        render request
      end
    end
  end

  private
    def set_product
      @product = @products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :unit, :quantity_container, :volume_container, :volume_type, :price, :vat, :category_id)
    end
end
