# == Schema Information
#
# Table name: product_offers
#
#  id         :integer          not null, primary key
#  offer_id   :integer          not null
#  product_id :integer          not null
#  type       :string           not null
#  value      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductOffer < ActiveRecord::Base
  belongs_to :offer
  belongs_to :product
end
