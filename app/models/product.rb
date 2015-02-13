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
#  category_id        :integer
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
  alias_attribute :netto_str, :price_str

  before_save :check_quantity_container

  def brutto(netto = nil)
    netto = self.price if netto.nil?
    ((netto * (100 + vat)) / 100).round(2)
  end

  def calculate_change_price(value, kind)
    case kind
      when 'constant'
        new_netto = price + value.to_f
      when 'percent'
        new_netto = (price * (100 + value.to_f)) / 100
    end
    new_brutto = brutto(new_netto)

    [currency_str(new_netto.round(2)), currency_str(new_brutto.round(2))]
  end

  def parameters
    quantity = "#{quantity_container}#{I18n.t('product.unit.pice_short')} x " if unit == 'package'
    "#{quantity}#{volume_container}#{volume_type}"
  end

  def name_with_parameters(separator = ', ')
    "#{name}#{separator}#{parameters}"
  end

  def vat_str
    "#{vat}%"
  end

  def price_str
    currency_str(price)
  end

  def brutto_str
    currency_str(brutto)
  end

  def currency_str(price)
    "#{price}#{I18n.t('currency')}"
  end

  def volume_str
    "#{volume_container}#{volume_type}"
  end

  def to_s
    name
  end

  private

  def check_quantity_container
    return unless unit == 'pice'
    self.quantity_container = 1
  end
end
