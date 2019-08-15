class ProductsController < ApplicationController
  before_action :set_product, only: %I[edit update]

  # TODO pagination
  def index
    @products = Product.includes(:warehouses)
    # @products = Product.includes(:warehouses).order("product_warehouses.product_id, product_warehouses.warehouse_id ASC")
    @warehouses = Warehouse.all.map(&:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
      format.xml { render xml: @products }
    end
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.product_warehouses.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
p @product.valid?
p @product.errors
    respond_to do |format|
      if @product.save
        format.html { redirect_to root_url, notice: 'Product was successfully created.' }
        format.json { render :index, status: :created, location: root_url }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_url, notice: 'Product was successfully updated.' }
        format.json { render :index, status: :ok, location: @products }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, 
        product_warehouses_attributes: [:id, :item_count, :low_item_threshold, :warehouse_id])
    end
end
