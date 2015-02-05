class ProductsController < Application::Base
  before_action :products
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :categories, only: [:edit, :new]

  def index
    @products = products.includes(:category)
  end

  def show
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

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :unit, :quantity_container, :volume_container, :volume_type, :price, :vat, :category_id)
    end
end
