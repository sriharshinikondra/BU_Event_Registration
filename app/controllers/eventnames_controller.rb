class EventnamesController < ApplicationController
  def index
    @eventnames = Eventname.all 
  end
  # GET /movies/1
  # GET /movies/1.json
  def show
    #  id = params[:id] # retrieve movie ID from URI route
    @eventname = set_eventname  #Eventname.find(id)
  end
  # GET /movies/new
  def new
    @eventname = Eventname.new
  end
  # GET /movies/1/edit
  def edit
    @eventname = set_eventname
  end
  def create
    @eventname = Eventname.create!(eventname_params)
    flash[:notice] = "#{@eventname.title} was successfully created."
    redirect_to eventnames_path
  end
  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    @eventname = set_eventname
    @eventname.update_attributes!(eventname_params)
    flash[:notice] = "#{@eventname.title} was successfully updated."
    redirect_to eventname_path(@eventname)
  end
  # DELETE /movies/1
  def destroy
    @eventname = set_eventname
    @eventname.destroy
    flash[:notice] = "Eventname '#{@eventname.title}' deleted."
    redirect_to eventnames_path
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eventname
      @eventname = Eventname.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def eventname_params
      params.require(:eventname).permit(:eventnamecode, :title, :description, :created_at)
    end
end