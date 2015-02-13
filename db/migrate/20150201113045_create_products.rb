class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :unit, null: false
      t.integer :quantity_container, default: 1
      t.decimal :volume_container, precision: 8, scale: 2, null: false
      t.string :volume_type, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :vat, null: false
      t.references :category, index: true
      t.references :company, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :products, :categories
  end
end
