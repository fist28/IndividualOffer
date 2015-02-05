module CompaniesHelper
  def last_offer_path(client)
    if client.offers.last
      company_client_offer_path(@selected_company, client, client.offers.last)
    else
      new_company_client_offer_path(@selected_company, client)
    end
  end
end
