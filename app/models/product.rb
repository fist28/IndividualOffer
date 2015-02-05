# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  unit               :string           not null
#  quantity_container :integer          default("1")
#  volume_container   :decimal(8, 2)    not null
#  volume_type        :string           not null
#  price              :decimal(8, 2)    not null
#  vat                :integer          not null
#  category_id        :integer          not null
#  company_id         :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_company_id   (company_id)
#

class Product < ActiveRecord::Base
  belongs_to :category
  has_many :offers, through: :product_offers
  has_many :product_offers
  belongs_to :company
  UNIT = %w(pice package).freeze
  VOLUME_TYPE = %w(g kg ml l).freeze

  validates :unit, inclusion: { in: UNIT }
  validates :volume_type, inclusion:  { in: VOLUME_TYPE }
  validates :name, :unit, :quantity_container, :price, :vat, :category_id, :company_id, :volume_type, :volume_container, presence: true
  validates :price, :volume_container, numericality: { greater_than: 0 }

  alias_attribute :netto, :price

  def brutto
    ((price * (100 + vat))/100).round(2)
  end

  def parameters
    quantity = "#{quantity_container}#{I18n.t('product.unit.pice_short')} x " if unit == 'package'
    "#{quantity}#{volume_container}#{volume_type}"
  end
end
