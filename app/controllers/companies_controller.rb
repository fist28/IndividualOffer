class CompaniesController < Application::Base
  def show

  end

  def new
    @company = current_user.companies.new
  end

  def create
    @company = current_user.companies.new(company_params)

    respond_to do |format|
      if @company.save
        session[:selected_company] = @company.id
        format.html { redirect_to products_path, notice: 'Company was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @selected_company.update(company_params)
        format.html { redirect_to @selected_company, notice: 'Company was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :nip, :address, :address_second_line, :city ,:post_code, :description, :contact)
  end
end
