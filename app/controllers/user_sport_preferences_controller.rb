
class UserSportPreferencesController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:show, :new, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:index, :create]

#------------------------------------------------authenticate_admin----------------------------------------------------------------
  # GET /usersports_preferences/1
  # GET /usersports_preferences/1.json
  def show
    @usersports_preference = UsersportsPreference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @usersports_preference }
    end
  end

  # GET /usersports_preferences/new
  # GET /usersports_preferences/new.json
  def new
    @usersports_preference = UsersportsPreference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @usersports_preference }
    end
  end

  # GET /usersports_preferences/1/edit
  def edit
    @usersports_preference = UsersportsPreference.find(params[:id])
  end

  # PUT /usersports_preferences/1
  # PUT /usersports_preferences/1.json
  def update
    @usersports_preference = UsersportsPreference.find(params[:id])

    respond_to do |format|
      if @usersports_preference.update_attributes(params[:usersports_preference])
        format.html { redirect_to @usersports_preference, :notice => 'Usersports preference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @usersports_preference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usersports_preferences/1
  # DELETE /usersports_preferences/1.json
  def destroy
    @usersports_preference = UsersportsPreference.find(params[:id])
    @usersports_preference.destroy

    respond_to do |format|
      format.html { redirect_to usersports_preferences_url }
      format.json { head :no_content }
    end
  end

#----------------------------------------------------------authenticate_user--------------------------------------------------
  # GET /usersports_preferences
  # GET /usersports_preferences.json
  def index
    @sport = Sport.find_by_sql("SELECT sports.name FROM usersports_preferences, sports WHERE usersports_preferences.user_id = #{current_user.id} AND usersports_preferences.sport_id = sports.id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @usersports_preferences }
    end
  end

  # POST /user_sport_preferences
  # POST /user_sport_preferences.json
  #   INPUT: sport_ids (value) list
  #   OUTPUT: SAVE usersports_preference (UsersportsPreference.object)
  #   FROM: views/sports/index
  #   TO: views/locations/location_list_selected
  #   2012.6.26 Yueying
  def create    
    sql = ActiveRecord::Base.connection()
    sql.execute("DELETE FROM user_sport_preferences WHERE user_id = " + current_user.id.to_s)

    sports = Sport.find(params[:sport_ids])
    sports.each do |sport|
      user_sport_preference = UserSportPreference.new
      user_sport_preference.user_id = current_user.id
      user_sport_preference.sport_id = sport.id
      user_sport_preference.save
    end

    respond_to do |format|
      format.html { redirect_to '/events/search_event', :notice => 'Sports preference has been saved.' }
    end
  end
end
