class CategoriesController < Application::Base
  before_action :categories
  before_action :set_category, only: [:update, :destroy]


  def index
  end

  def new
    @category = selected_company.categories.new
  end

  def create
    category = selected_company.categories.new(category_params)
    respond_to do |format|
      if category.save
        format.html { redirect_to company_categories_path, notice: 'Offer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to company_categories_path, notice: '' }
        format.json { render nothing: true, status: :ok, content_type: "text/html" }
      else
        format.html { render :index }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to company_categories_path, notice: '' }
    end
  end

  private

  def set_category
    @category = selected_company.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end