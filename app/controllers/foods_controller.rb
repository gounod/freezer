class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]
  before_action :get_base_qr_url, only: [:show, :edit, :update, :destroy, :index]
  http_basic_authenticate_with name: 'freezer', password: 'freezer', only: [:create,:destroy]

  # GET /foods
  # GET /foods.json
  def index
    if params[:loc]
      @foods = Food.where(:location => params[:loc])
      @location_name = Food::LOCATIONS[params[:loc]]
    else
      @foods = Food.all
    end
    @all_qr_code = RQRCode::QRCode.new( "#{@url_for_qr_code_base}", :size => 5, :level => :h )
    @locations = {}
    Food::LOCATIONS.each do |key,value|
      @locations[key] = RQRCode::QRCode.new( "#{@url_for_qr_code_base}/location/#{key}", :size => 6, :level => :h )
    end
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods
  # POST /foods.json
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1
  # PATCH/PUT /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
      url_for_qr_code = "#{@url_for_qr_code_base}/#{@food.id}"
      @edit_qr_code = RQRCode::QRCode.new( "#{url_for_qr_code}/edit", :size => 4, :level => :h )
    end

    def get_base_qr_url
      host_port = "" 
      host_port = ":3000" if request.port.to_i != 80
      @url_for_qr_code_base = "#{request.protocol}#{request.host}#{host_port}/foods"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:title, :embedded_at, :product_code, :best_before, :location)
    end
end
