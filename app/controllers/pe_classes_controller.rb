
class PeClassesController < ApplicationController
  layout 'home'
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index, :show, :new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!, :only => [:news_list, :home]

#----------------------------------------------authenticate_admin-------------------------------------------
  # GET /pe_classes
  # GET /pe_classes.json
  def index
    @pe_classes = PeClass.all
    render :layout => nil
  end

  # GET /pe_classes/1
  # GET /pe_classes/1.json
  def show
    @pe_class = PeClass.find(params[:id])
    render :layout => nil
  end

  # GET /pe_classes/new
  # GET /pe_classes/new.json
  def new
    @pe_class = PeClass.new
    @schools = School.all
    @teachers = Teacher.all
    render :layout => nil
  end

  # GET /pe_classes/1/edit
  def edit
    @pe_class = PeClass.find(params[:id])
    @schools = School.all
    @teachers = Teacher.all
    render :layout => nil
  end

  # POST /pe_classes
  # POST /pe_classes.json
  def create
    @pe_class = PeClass.new(params[:pe_class])

    respond_to do |format|
      if @pe_class.save
        format.html { redirect_to @pe_class, :notice => 'Pe class was successfully created.' }
        format.json { render :json => @pe_class, :status => :created, :location => @pe_class }
      else
        format.html { render :action => "new" }
        format.json { render :json => @pe_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pe_classes/1
  # PUT /pe_classes/1.json
  def update
    @pe_class = PeClass.find(params[:id])

    respond_to do |format|
      if @pe_class.update_attributes(params[:pe_class])
        format.html { redirect_to @pe_class, :notice => 'Pe class was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @pe_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pe_classes/1
  # DELETE /pe_classes/1.json
  def destroy
    @pe_class = PeClass.find(params[:id])
    @pe_class.destroy

    respond_to do |format|
      format.html { redirect_to pe_classes_url }
      format.json { head :no_content }
    end
  end

#----------------------------------------------authenticate_user-------------------------------------------
  # news_list
  #   INPUT: user_id (sesion value)
  #   OUTPUT: musics (Music.object), music_likes (MusicLike.object), user_funs (UserFun.object)
  #   FROM: /views/pe_classes/home
  #   TO: views/pe_classes/news_list
  #   2012.7.5 Yueying
  def news_list
    @activities = PeClass.find_news(current_user.id)
    
  end

#------------------------------------------------------home---------------------------------------------
  # home ##top##
  #   FROM: views/pe_classes/home1
  #   INCLUDE VIEWS: /views/team_points/point_list, /views/teams/team_information_list, /views/pe_classes/news_list
  #   INCLUDE CONTROLLERS: /controllers/team_points_controller/point_list, /controllers/teams_controller/team_information_list, /controllers/pe_classes_controller/news_list
  #   2012.7.20 Yueying
  def home
    # /controllers/team_points_controller/point_list
    # exapt user's own team
    @user = current_user
    @team = Team.find_by_user1(current_user.id)
    @teammate = Team.find_teammate(current_user.id)
    pe_class_id = @user.pe_class_id
    team_ids = Team.find_by_sql("SELECT teams.id FROM teams, users WHERE users.pe_class_id = " + pe_class_id.to_s)
    @teams = []
    if Team.find_by_user1(current_user.id) != nil
      @teams = Team.find_teams_by_user(current_user.id)
    end

    # /controllers/pe_classes_controller/news_list
    @activities = PeClass.find_news(current_user.id)
  end
    end
