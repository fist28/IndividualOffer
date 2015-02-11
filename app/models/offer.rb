# == Schema Information
#
# Table name: offers
#
#  id         :integer          not null, primary key
#  company_id :integer          not null
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
  has_many :products, through: :product_offers
  has_many :product_offers, dependent: :destroy
  accepts_nested_attributes_for :product_offers, allow_destroy: true, reject_if: proc { |a| a[:value].blank? }

  validates :product_offers, presence: true

  def base?(current_user)
    company.in?(current_user.companies)
  end

end
