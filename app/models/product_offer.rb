# == Schema Information
#
# Table name: product_offers
#
#  id         :integer          not null, primary key
#  offer_id   :integer
#  product_id :integer
#  kind       :string
#  value      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_product_offers_on_offer_id                 (offer_id)
#  index_product_offers_on_offer_id_and_product_id  (offer_id,product_id) UNIQUE
#  index_product_offers_on_product_id               (product_id)
#

class ProductOffer < ActiveRecord::Base
  belongs_to :offer
  belongs_to :product

  KIND = %w(percent constant).freeze

  validates :kind, inclusion:  { in: KIND }
  validates :value, numericality: true
  validates :product_id, uniqueness: {scope: :offer_id}, presence: true

end
