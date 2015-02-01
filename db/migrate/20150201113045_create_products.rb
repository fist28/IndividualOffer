class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :unit, null: false
      t.integer :quantity_container, default: 1
      t.decimal :volume_container, precision: 8, scale: 2
      t.decimal :price, precision: 8, scale: 2
      t.integer :vat, null: false
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :products, :categories
  end
end
