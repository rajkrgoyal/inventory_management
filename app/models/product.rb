class Product < ApplicationRecord
  has_many :product_warehouses

  has_many :warehouses, through: :product_warehouses

  before_create :create_unique_identifier

  def create_unique_identifier
    loop do
      self.sku_code = SecureRandom.hex(4) # or you any like UUID tools
      break unless self.class.exists?(sku_code: sku_code)
    end
  end
end
