
class TeamsController < ApplicationController
  layout 'dashboard'
  # devise gem
  before_filter :authenticate_admin!, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create, :team_information, :team_information_list, :levelup, :home, :render_search_team, :search_team]

#----------------------------------------------------authenticate_admin-------------------------------------------------------
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, :notice => 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  # destroy
  #   INPUT:
  #   OUTPUT: DELETE
  #   FROM: controllers/teams_controller/create
  #   2012.7.11 Yueying
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

#----------------------------------------------------authenticate_user-------------------------------------------------------
  # GET /teams/new
  # GET /teams/new.json
  # 2012.7.30 Yueying
  def new
    @team = Team.new
    @sports = Sport.all
    @levels = Level.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @team }
    end
  end

  # POST /teams
  # POST /teams.json
  # create
  #   2012.7.30 Yueying
  def create
    # if he/she has already created a team, but no one else join the team
    # destroy the old team, teammember firstly
    if Team.find_by_user_id(current_user.id) != nil
      team = Team.find_by_user_id(current_user.id)
      teammember = Teammember.find_by_team_id(team.id)
      teammember.destroy
      team.destroy
    end
    
    # create team
    @team = Team.new(params[:team])
    @team.user_id = current_user.id
    sport_level_id = SportLevel.find_by_sql("SELECT sport_levels.id FROM sport_levels WHERE sport_levels.sport_id = " + @team.sport_id.to_s + " AND sport_levels.name = 1")
    @team.sport_level_id = SportLevel.find_by_id(sport_level_id)
    @team.save

    # create teammember
    teammember = Teammember.new
    teammember.team_id = @team.id
    teammember.user_id = current_user.id
    teammember.save

    redirect_to '/teams/render_search_team', :notice_create_team => 'Team was successfully created.'
  end

  # team_information
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW team.name, teammate.firstname&lastname, user.firstname$lastname
  #   FROM: views/teams/home
  #   TO: views/teams/team_information 
  #   2012.6.29 Yueying
  def team_information
    @team = Team.find_by_user1(current_user.id)
    @teammate = Team.find_teammate(current_user.id)
    @user = current_user

    flash.now[:notice] = "You need a teammember!"
    render :controller => 'teams', :action => 'team_information'

  end

  # team_information_list
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW team (Team.object), sport (Sport.object), sport_level (SportLevel.object)
  #   FROM: views/classes/home
  #   TO: views/teams/teams_information
  #   2012.7.3 Yueying
  def team_information_list
    @teams = Team.find_teams_by_user(current_user.id)
    
  end

  # levelup
  #   INPUT: user_id (session value)
  #   OUTPUT: SAVE sport_level
  #   FROM: /views/events/my_event_information
  #   TO:
  #   2012.7.16 Yueying
  def levelup
    # update team.sport_level_id
    team = Team.find_by_user1(current_user.id)
    sport_level = SportLevel.first(:conditions => ['id > ?', team.sport_level_id], :order => 'id ASC')
    team.update_attribute(:sport_level_id, sport_level.id)

    # save user_point
    user_point = UserPoint.new
    user_point.add_point(current_user.id, 50000, 'event')
   
    # save team_point 
    team_point = TeamPoint.new
    team = Team.find_by_user1(current_user.id)
    team_point.add_point(team.id, 100000)

    redirect_to '/teams/home'
  end

#---------------------------------------------------home-------------------------------------------
  # home ##top##
  #   FROM: views/teams/home1
  #   INCLUDE VIEWS: /views/teams/team_information, /views/events/my_event_information, /views/sport_levels/guidance
  #   INCLUDE CONTROLLERS: /controllers/teams_controller/team_information, /controllers/events_controller/my_event_information, /controllers/sport_levels_controller/guidance
  #   2012.7.20 Yueying
  def home
    # /controllers/teams_controller/team_information
    @team = Team.find_by_user1(current_user.id)
    team = Team.find_by_user1(current_user.id)
    @team_point = TeamPoint.find_by_team_id(team.id)
    @teammate = Team.find_teammate(current_user.id)
    @user_funs = UserFun.find_all_by_user_id(current_user.id)
    @user = current_user
    render :layout => 'home'
  end

  # render_search_teams
  # 2012.7.29 Yueying
  def render_search_team
    # if user.active_code > 1, can't show this page, redirect to home page   
    if current_user.active_code > 1
      redirect_to "/users/home"
    # show info
    else
      # level
      @levels = Level.all
      # team
      @teams = nil
      @teams1 = nil

      render :file => '/teams/search_team'  
    end
  end

  # search_team ##top##
  # 2012.7.29 Yueying
  def search_team
    # if user.active_code > 1, can't show this page, redirect to home page!!!   
    if current_user.active_code > 1
      redirect_to "/users/home"
    # show info
    else
      # level
      @levels = Level.all
      # sport
      if params[:commit] != "select" and params[:commit] != "next" and params[:commit] != "join" and params[:commit] != nil
        sql = ActiveRecord::Base.connection()
        sql.execute("DELETE FROM user_sport_preferences WHERE user_id = " + current_user.id.to_s)
        sport = Sport.find(params[:commit].to_i)
        user_sport_preference = UserSportPreference.new
        user_sport_preference.user_id = current_user.id
        user_sport_preference.sport_id = sport.id
        user_sport_preference.save
      else
        # select sport_level
        if params[:commit] == "select"
           level_id = params[:level_id]
          if Team.find_available_by_sport_and_level(current_user.id, level_id).any?
            @teams = Team.find_available_by_sport_and_level(current_user.id, level_id)
          else
            @teams = nil
          end
          if Team.find_available_by_sport(current_user.id).any?
            @teams1 = Team.find_available_by_sport(current_user.id)
          else
            @teams1 = nil
            flash[:notice_search_result] = "You can create the 1st team of " + "#{UserSportPreference.find_by_user_id(current_user.id).sport.name}"
          end
        # join a team: save team, teammember
        elsif params[:commit] == "join"
          # get team_id
          hash = params[:join]
          if hash != nil
            hash_invert = hash.invert
            team_id = hash_invert.values_at("join").first.to_i
          end
          # create teammember
          team = Team.find(team_id)
          teammember = Teammember.new
          teammember.team_id = team.id
          teammember.user_id = current_user.id
          teammember.save
      
          # modify teammembers' active_code = 2
          teammember1 = User.find(current_user.id)
          teammember2 = team.user
          teammember1.update_attribute(:active_code, 2)
          teammember2.update_attribute(:active_code, 2)
     
          # modify team.is_available = 1
          team = Team.find(team_id)
          team.update_attribute(:is_available, 0)

          redirect_to '/teams/home'
        elsif params[:commit] == "next"
          redirect_to "/teams/home"
        end
      end
    end
  end
end
