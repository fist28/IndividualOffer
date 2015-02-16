class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :nip, limit: 5
      t.string :address
      t.string :address_second_line
      t.string :city
      t.integer :post_code
      t.text :description
      t.text :contact
      t.references :company, index: true

      t.timestamps null: false
    end
    add_foreign_key :companies, :companies
  end
end
