class Product < ApplicationRecord
  has_many :Warehouses, through: :product_warehouse
end
