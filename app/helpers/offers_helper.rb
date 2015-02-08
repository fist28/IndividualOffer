module OffersHelper
  def title_base(offer)
    if offer.base?(@current_user) == true
      t('offer.title.show_base')
    else
      t('offer.title.show')
    end
  end
end
