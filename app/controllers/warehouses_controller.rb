class WarehousesController < ApplicationController
  # GET /warehouses/new
  def new
    @warehouse = Warehouse.new
  end

  # POST /warehouses
  # POST /warehouses.json
  def create
    @warehouse = Warehouse.new(warehouse_params)
    respond_to do |format|
      if @warehouse.save
        format.html { redirect_to root_url, notice: 'Warehouse was successfully created.' }
        format.json { render :index, status: :created, location: root_url }
      else
        format.html { render :new }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list
  def warehouse_params
    params.require(:warehouse).permit(:name, :wh_code, :max_apacity, :pincode)
  end
end
