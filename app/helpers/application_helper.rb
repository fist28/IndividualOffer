module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def last_offer_path(client)
    if client.offers.any?
      offer_path(client.offers.last.id)
    else
      new_offer_path
    end
  end
end
