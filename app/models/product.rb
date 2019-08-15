class Product < ApplicationRecord

  # order is to display on product listing page
  has_many :product_warehouses#, -> { order(:warehouse_id) } #, class_name: "ProductWarehouse"

  has_many :warehouses, through: :product_warehouses

  accepts_nested_attributes_for :product_warehouses, allow_destroy: true, reject_if: :all_blank

  # validates_associated :product_warehouses
  validates_presence_of :name

  validates :price, numericality: {greater_than: 0}

  before_validation :create_unique_identifier

  def create_unique_identifier
    loop do
      self.sku_code = SecureRandom.hex(4).upcase # or any like UUID tools
      break unless self.class.exists?(sku_code: sku_code)
    end
  end
end
