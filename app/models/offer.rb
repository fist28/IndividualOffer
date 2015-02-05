# == Schema Information
#
# Table name: offers
#
#  id         :integer          not null, primary key
#  company_id :integer
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_offers_on_company_id  (company_id)
#

class Offer < ActiveRecord::Base
  belongs_to :company
  has_many :product_offers

end
