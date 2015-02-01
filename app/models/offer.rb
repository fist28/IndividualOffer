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

class Offer < ActiveRecord::Base
  belongs_to :company
end
