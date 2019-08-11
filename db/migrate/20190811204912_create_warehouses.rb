class CreateWarehouses < ActiveRecord::Migration[5.2]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :wh_code, limit: 16
      t.integer :max_apacity # MEDIUMINT
      t.string :pincode, limit: 15

      t.timestamps
    end
    add_index :warehouses, :name
    add_index :warehouses, :wh_code, unique: true
  end
end
