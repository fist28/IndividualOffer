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
  has_many :clients, :class_name => 'Company', :dependent => :destroy, :foreign_key => :company_id
  belongs_to :parent, :class_name => 'Company', :foreign_key => :company_id


  has_many :offers
end
