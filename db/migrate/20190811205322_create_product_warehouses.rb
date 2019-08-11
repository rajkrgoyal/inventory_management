class CreateProductWarehouses < ActiveRecord::Migration[5.2]
  def change
    create_table :product_warehouses do |t|
      t.references :product, foreign_key: true
      t.references :warehouse, foreign_key: true
      t.integer :item_count, default: 0
      t.integer :low_item_threshold, limit: 3, default: 10

      t.timestamps
    end
  end
end
