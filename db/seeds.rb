# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command
# (or created alongside the database with db:setup).
#
class Seed
  attr_reader :half_count, :third_count

  def initialize(half_count, third_count)
    @half_count = half_count
    @third_count = third_count
  end

  def odd_item_count(threshold)
    if @half_count.odd?
      rand(threshold + 1..threshold + 1000)
    else
      rand(threshold - 1)
    end
  end

  def third_item_count(threshold)
    if (@third_count % 3).zero?
      rand(threshold - 1)
    else
      rand(threshold + 1..threshold + 1000)
    end
  end

  def generate_warehouse_data(wh_id, product)
    threshold = rand(50..100)
    case wh_id
    when 1 # Delhi
      @half_count += 1
      item_count = odd_item_count(threshold)
    when 3 # Bangalore
      @third_count += 1
      item_count = third_item_count(threshold)
    else # 2 Mumbai
      item_count = rand(threshold + 1..threshold + 1000)
    end
    create_product_warehouse(product, wh_id, threshold, item_count)
  end

  def generate_warehouse
    locations = %w[Delhi Mumbai Bangalore]
    locations.each do |location|
      next if Warehouse.where(wh_code: location.downcase).first

      Warehouse.create(name: location,
                       wh_code: location.downcase,
                       max_apacity: rand(3333..4444),
                       pincode: rand(332_211..443_322))
    end
  end

  def generate_products
    wh_array = [1, 2, 3]
    60.times do
      product = Product.create(name: Faker::Commerce.product_name,
                               price: Faker::Commerce.price)
      warehouse_id = rand(1..3)

      generate_warehouse_data(warehouse_id, product)
      warehouse_arr = wh_array - [warehouse_id]
      warehouse_id = warehouse_arr[rand(warehouse_arr.length)]
      generate_warehouse_data(warehouse_id, product)

      # binding.pry
    end
  end

  def generate_product_warehouse
    product = Product.joins("LEFT JOIN product_warehouses w
                on products.id=w.product_id and w.warehouse_id not in (2,3)")
                     .where("w.warehouse_id": nil).first
    wh_id = 1
    threshold = rand(50..100)
    item_count = rand(threshold - 1)
    create_product_warehouse(product, wh_id, threshold, item_count)
  end

  def create_product_warehouse(product, wh_id, threshold, item_count)
    product.product_warehouses.create(warehouse_id: wh_id,
                                      low_item_threshold: threshold,
                                      item_count: item_count)
  end
end

@half_count = 0 # every 2nd product should be below threshold
@third_count = 0 # every 3rd product should be below threshold

@seed = Seed.new(@half_count, @third_count)
@seed.generate_warehouse
@seed.generate_products
@seed.generate_product_warehouse if @seed.half_count.odd?
