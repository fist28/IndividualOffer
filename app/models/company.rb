# == Schema Information
#
# Table name: companies
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  nip         :integer
#  address     :string
#  city        :string
#  post_code   :integer
#  description :text
#  contact     :text
#  company_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Company < ActiveRecord::Base
  belongs_to :company
end
