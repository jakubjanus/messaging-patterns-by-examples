class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_number, index: true, null: false
      t.string :name
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
