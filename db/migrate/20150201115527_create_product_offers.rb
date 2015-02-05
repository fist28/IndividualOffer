class CreateProductOffers < ActiveRecord::Migration
  def change
    create_table :product_offers do |t|
      t.references :offer, null: false, index: true
      t.references :product, null: false, index: true
      t.string :type
      t.decimal :value

      t.timestamps null: false
    end
    add_foreign_key :product_offers, :offers
    add_foreign_key :product_offers, :products
  end
end
