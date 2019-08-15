class Warehouse < ApplicationRecord
  has_many :product_warehouses
  has_many :products, through: :product_warehouses

  validates :name, :wh_code, :pincode, presence: true

  validates_uniqueness_of :wh_code

  validates :wh_code, length: { in: 4..16 }

  after_create :assign_products

  def assign_products
    Product.all.each do |product|
      self.products << product
    end
  end
end
