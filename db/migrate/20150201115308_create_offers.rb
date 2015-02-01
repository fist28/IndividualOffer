class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :company, null: false, index: true
      t.text :comment

      t.timestamps null: false
    end
    add_foreign_key :offers, :companies
  end
end
