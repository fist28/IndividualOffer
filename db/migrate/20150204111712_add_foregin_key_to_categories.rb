class AddForeginKeyToCategories < ActiveRecord::Migration
  def change
    add_foreign_key :categories, :companies
    add_foreign_key :products, :companies
  end
end
