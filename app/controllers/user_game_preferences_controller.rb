
class UserGamePreferencesController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index, :show, :new, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:create]

#------------------------------------------------------authenticate_admin---------------------------------------------------------
  # GET /user_game_preferences
  # GET /user_game_preferences.json
  def index
    @user_game_preferences = UserGamePreference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user_game_preferences }
    end
  end

  # GET /user_game_preferences/1
  # GET /user_game_preferences/1.json
  def show
    @user_game_preference = UserGamePreference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user_game_preference }
    end
  end

  # GET /user_game_preferences/new
  # GET /user_game_preferences/new.json
  def new
    @user_game_preference = UserGamePreference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user_game_preference }
    end
  end

  # GET /user_game_preferences/1/edit
  def edit
    @user_game_preference = UserGamePreference.find(params[:id])
  end

  # PUT /user_game_preferences/1
  # PUT /user_game_preferences/1.json
  def update
    @user_game_preference = UserGamePreference.find(params[:id])

    respond_to do |format|
      if @user_game_preference.update_attributes(params[:user_game_preference])
        format.html { redirect_to @user_game_preference, :notice => 'User game preference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user_game_preference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_game_preferences/1
  # DELETE /user_game_preferences/1.json
  def destroy
    @user_game_preference = UserGamePreference.find(params[:id])
    @user_game_preference.destroy

    respond_to do |format|
      format.html { redirect_to user_game_preferences_url }
      format.json { head :no_content }
    end
  end

#-----------------------------------------------authenticate_user--------------------------------------------------
  # POST /user_game_preferences
  # POST /user_game_preferences.json
  # create
  #   INPUT: game_ids (value) list
  #   OUTPUT: SAVE user_games_preference (UsersportsPreference.object)
  #   FROM: views/games/index
  #   TO: views/funs/list_selected
  #   2012.7.6 Yueying
  def create
    sql = ActiveRecord::Base.connection()
    sql.execute("DELETE FROM user_game_preferences WHERE user_id = " + current_user.id.to_s)

    if params[:game_ids] == nil
    else
      games = Game.find(params[:game_ids])
      games.each do |game|
        user_game_preference = UserGamePreference.new
        user_game_preference.user_id = current_user.id
        user_game_preference.game_id = game.id
        user_game_preference.save
      end
    end

    respond_to do |format|
      format.html { redirect_to '/funs/search_fun', :notice => 'UserGamePreference was successfully created.' }
    end
  end

end
