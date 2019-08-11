class Warehouse < ApplicationRecord
  has_many :products, through: :product_warehouse
end
