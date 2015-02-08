class CreateProductOffers < ActiveRecord::Migration
  def change
    create_table :product_offers do |t|
      t.references :offer, index: true
      t.references :product, index: true
      t.string :kind
      t.decimal :value

      t.timestamps null: false
    end
    add_foreign_key :product_offers, :offers
    add_foreign_key :product_offers, :products
  end
end
