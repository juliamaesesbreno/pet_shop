class AnimalsController < ApplicationController
  before_action :check_if_logged_in, :set_animal, only: [:show, :edit, :update, :destroy, :change_status_sale, :change_status_sold, :species, :total_amount_sale]
  # GET /animals
  # GET /animals.json
  def index
    @animal = Animal.all
  end
  # GET /animals/1
  # GET /animals/1.json
  def show
    @animal = Animal.find(params[:id])
  end
  # GET /animals/new
  def new
    @animal = Animal.new
  end
  # GET /animals/1/edit
  def edit
  end
  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)
    respond_to do |format|
      if @animal.save
        format.html { redirect_to @animal}
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to @animal}
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_status_sale
      @animal.Status = "For Sale"
      @animal.save
      redirect_to animals_path  
  end

  def change_status_sold
      @animal.Status = "Sold"
      @animal.save
      redirect_to animals_path  
  end

  def show_inventory
    @animals_for_sale = Animal.where(Status: 'For Sale').group_by(&:Species)
    @animals_for_sold = Animal.where(Status: 'Sold').group_by(&:Species)
  end

  def total_amount_sale
    @animal = Animal.sum(&:Price)
  end
  # DELETE /animals/1
  # DELETE /animals/1.json

  def filter
    if params[:query].blank?
      @animal = Animal.all
    else
      field = params[:field]
      query = "%#{params[:query]}%"
      @animal = Animal.where("#{field} LIKE ?", query)
    end
  end

  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to animals_url}
      format.json { head :no_content }
    end
  end

  def check_if_logged_in
    redirect_to login_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_animal
    id = params[:animal_id] || params[:id]
    @animal = Animal.find(id)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      params.require(:animal).permit(:Species, :Breed, :Price, :Status)
    end
end
