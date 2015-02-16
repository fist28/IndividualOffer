# == Schema Information
#
# Table name: companies
#
#  id                  :integer          not null, primary key
#  name                :string
#  nip                 :integer
#  address             :string
#  address_second_line :string
#  city                :string
#  post_code           :integer
#  description         :text
#  contact             :text
#  company_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#
# Indexes
#
#  index_companies_on_company_id  (company_id)
#  index_companies_on_user_id     (user_id)
#

class Company < ActiveRecord::Base
  belongs_to :user
  has_many :clients, class_name: 'Company', dependent: :destroy, foreign_key: :company_id
  belongs_to :parent, class_name: 'Company', foreign_key: :company_id

  has_many :categories, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :offers, dependent: :destroy

  validates :name, :address, :city, :post_code, presence: true

  def main?
    !parent.nil?
  end

  def to_s
    name
  end
end
