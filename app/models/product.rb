# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  unit               :string           not null
#  quantity_container :integer          default("1")
#  volume_container   :decimal(8, 2)
#  price              :decimal(8, 2)
#  vat                :integer          not null
#  category_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :category
  has_many :product_offers
end
