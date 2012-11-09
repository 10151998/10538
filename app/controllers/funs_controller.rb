class FunsController < ApplicationController
  layout 'dashboard'
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:new, :edit, :create, :updated, :destroy]
  before_filter :authenticate_user!, :only => [:index, :show, :fun_list, :my_fun_list, :fun_information, :search_fun]

#-----------------------------------------------------authenticate_admin-------------------------------------------------------
  # GET /funs
  # GET /funs.json
  def index
    @funs = Fun.all
    render :layout => 'home'
  end

  # GET /funs/1
  # GET /funs/1.json
  def show
    @fun = Fun.find(params[:id])
    render :layout => nil
  end

  # GET /funs/new
  # GET /funs/new.json
  # new
  #   INPUT: 
  #   OUTPUT:
  #   FROM: views/locations/location_list_selected
  #   TO: views/events/new -> views/events/_form
  #   2012.7.16 Yueying 
  def new
    @fun = Fun.new
    @games = Game.all
    @schools = School.all
    render :layout => nil
  end

  # GET /funs/1/edit
  def edit
    @fun = Fun.find(params[:id])
    @games = Game.all
    @schools = School.all
    render :layout => nil
  end

  # POST /funs
  # POST /funs.json
  # create
  #   INPUT: user_id (session value), game_id (value), datetime (value), location (value)
  #   OUTPUT: SAVE event (Event.object), Location (Location.object)
  #   FROM: views/funs/_form
  #   TO: 
  #   2012.7.16 Yueying
  def create
    # create fun
    fun = Fun.new(params[:fun])
    fun.save

    # create location
    fun_location = FunLocation.new(:name => params[:fun_location_name], :address => params[:fun_location_address] )
    fun_location.save
    fun.update_attribute(:fun_location_id, fun_location.id)

    redirect_to fun

  end

  # PUT /funs/1
  # PUT /funs/1.json
  def update
    @fun = Fun.find(params[:id])

    respond_to do |format|
      if @fun.update_attributes(params[:fun])
        format.html { redirect_to @fun, :notice => 'Fun was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @fun.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /funs/1
  # DELETE /funs/1.json
  def destroy
    @fun = Fun.find(params[:id])
    @fun.destroy

    respond_to do |format|
      format.html { redirect_to funs_url }
      format.json { head :no_content }
    end
  end

#-------------------------------------------------------authenticate_user---------------------------------------------------------
  # fun_list
  #   INPUT: game_ids (value)
  #   OUTPUT: funs (Fun.objects)
  #   FROM: views/games/index
  #   TO: views/funs/list_selected
  #   2012.7.6 Yueying
  #   not include the registered funs
  def fun_list
    @funs = Fun.all
    @user = current_user
    @team = Team.find_by_user1(current_user.id)
    @teammate = Team.find_teammate(current_user.id)
    @user_funs = UserFun.find_all_by_user_id(current_user.id)
    render :layout => 'home'
  end

  # my_fun_list
  #   INPUT: user_ids (value)
  #   OUTPUT: funs (Fun.object)
  #   FROM: views/funs/home
  #   TO: views/funs/list_by_user
  #   2012.7.6 Yueying
  def my_fun_list
    @user_funs = UserFun.find_all_by_user_id(current_user.id)
  end

  # fun_information
  #   2012.7.16 Yueying
  def fun_information
  end

  # search_fun ##top##
  #   FROM: views/funs/home
  #   TO: views/admin/home
  #   INCLUDE VIEWS: views/games/index, views/fun_locations/index
  #   COPY CONTROLLERS: controllers/games_controller/index, controllers/fun_location_controller/index
  #   2012.7.19 Yueying
  def search_fun
    # views/games/index
    @games = Game.all
    # views/fun_locations/index
    # if user click "search" without choose sport
    @fun_locations = nil
    if !UserFun.find_by_sql("SELECT * FROM user_game_preferences WHERE user_game_preferences.user_id = " + current_user.id.to_s).any?
      @fun_locations = FunLocation.find_by_school(current_user.id)
      @json = FunLocation.find_by_school(current_user.id).to_gmaps4rails do |fun_location, marker|  
        @funs = Fun.find_by_fun_location_school(fun_location.id, current_user.id)
        @user_fun = UserFun.new
        marker.infowindow render_to_string(:partial => "/funs/datetime_list1", :locals => {:user_fun => @user_fun, :funs => @funs})
        marker.json({:id => fun_location.id})
      end
    # if user click "search" after choose sport
    else
      @fun_locations = FunLocation.find_by_game_school(current_user.id)
      @json = FunLocation.find_by_game_school(current_user.id).to_gmaps4rails do |fun_location, marker| 
        @funs = Fun.find_by_game_fun_location_school(fun_location.id, current_user.id)
        @user_fun = UserFun.new
        marker.infowindow render_to_string(:partial => "/funs/datetime_list1", :locals => {:user_fun => @user_fun, :funs => @funs})
        marker.json({:id => fun_location.id})
      end
    end     
  end

end
