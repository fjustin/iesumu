class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:index,:show]
  before_action :correct_user, only: [:edit,:update, :destroy]

  # GET /houses
  # GET /houses.json
  def index
    @stations = Station.all
    @houses = House.includes(:station).references(:station).station(params[:station])
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @stations = Station.all
    @house = House.includes(:station)
                 .references(:station)
                 .find_by_id(params[:id]) or raise ActiveRecord::RecordNotFound
  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)
    @house.user_id =  current_user.id
    respond_to do |format|
      if @house.save
        format.html { redirect_to @house, notice: 'House was successfully created.' }
        format.json { render :show, status: :created, location: @house }
      else
        format.html { render :new }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: 'House was successfully updated.' }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:name,:content,:user_id,:status,:member,:price,:station_id,:address,images: [])
    end

    def correct_user
      house = House.find(params[:id])
      if current_user.id != house.user.id
        flash[:notice] = "権限がありません"
        redirect_to houses_path
      end
    end
end
