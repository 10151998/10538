
class FunLocationsController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index_admin, :show, :new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!, :only => [:index]

#----------------------------------------------------authenticate_user---------------------------------------------------
  # GET /fun_locations
  # GET /fun_locations.json
  # index
  #   INPUT:
  #   OUTPUT: DELETE
  #   FROM: controllers/teams_controller/create
  #   2012.7.16 Yueying
  def index
    @fun_locations = FunLocation.find_by_game_school(current_user.id)
    @json = FunLocation.find_by_game_school(current_user.id).to_gmaps4rails do |fun_location, marker|     
      @funs = Fun.find_by_game_fun_location_school(fun_location.id, current_user.id)
      @user_fun = UserFun.new
      marker.infowindow render_to_string(:partial => "/funs/datetime_list1", :locals => {:user_fun => @user_fun, :funs => @funs})
      marker.json({:id => fun_location.id})
    end
  end

#----------------------------------------------------authenticate_admin---------------------------------------------------
  def index_admin
    @fun_locations = FunLocation.all 
    render :layout => nil
  end

  # GET /fun_locations/1
  # GET /fun_locations/1.json
  def show
    @fun_location = FunLocation.find(params[:id])
    render :layout => nil
  end

  # GET /fun_locations/new
  # GET /fun_locations/new.json
  def new
    @fun_location = FunLocation.new
    render :layout => nil
  end

  # GET /fun_locations/1/edit
  def edit
    @fun_location = FunLocation.find(params[:id])
    render :layout => nil
  end

  # POST /fun_locations
  # POST /fun_locations.json
  def create
    @fun_location = FunLocation.new(params[:fun_location])

    respond_to do |format|
      if @fun_location.save
        format.html { redirect_to @fun_location, :notice => 'Fun location was successfully created.' }
        format.json { render :json => @fun_location, :status => :created, :location => @fun_location }
      else
        format.html { render :action => "new" }
        format.json { render :json => @fun_location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fun_locations/1
  # PUT /fun_locations/1.json
  def update
    @fun_location = FunLocation.find(params[:id])

    respond_to do |format|
      if @fun_location.update_attributes(params[:fun_location])
        format.html { redirect_to @fun_location, :notice => 'Fun location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @fun_location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fun_locations/1
  # DELETE /fun_locations/1.json
  def destroy
    @fun_location = FunLocation.find(params[:id])
    @fun_location.destroy

    respond_to do |format|
      format.html { redirect_to fun_locations_url }
      format.json { head :no_content }
    end
  end
end
