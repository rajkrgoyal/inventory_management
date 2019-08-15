class ProductWarehouse < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse

  validates_uniqueness_of :product_id,
                          scope: :warehouse_id,
                          message: 'Product is already in warehouse.'

  default_scope { order(warehouse_id: :asc) }
end
