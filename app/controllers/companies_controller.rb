class CompaniesController < Application::Base
  def show

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
    params.require(:company).permit(:name, :nip, :address, :city ,:post_code, :description, :contact)
  end
end
