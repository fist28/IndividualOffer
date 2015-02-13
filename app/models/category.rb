# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  company_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :products, dependent: :nullify
  belongs_to :company

  validates :company_id, :name, presence: true

  def self.without_category
    @without_category ||= Category.new("-", )
  end

  def to_s
    name
  end


end
