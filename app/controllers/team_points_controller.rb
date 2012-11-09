
class TeamPointsController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index, :show, :new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!, :only => [:point_list]

#--------------------------------------------------authenticate_admin---------------------------------------------------------
  # GET /team_points
  # GET /team_points.json
  def index
    @team_points = TeamPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @team_points }
    end
  end

  # GET /team_points/1
  # GET /team_points/1.json
  def show
    @team_point = TeamPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @team_point }
    end
  end

  # GET /team_points/new
  # GET /team_points/new.json
  def new
    @team_point = TeamPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @team_point }
    end
  end

  # GET /team_points/1/edit
  def edit
    @team_point = TeamPoint.find(params[:id])
  end

  # POST /team_points
  # POST /team_points.json
  def create
    @team_point = TeamPoint.new(params[:team_point])

    respond_to do |format|
      if @team_point.save
        format.html { redirect_to @team_point, :notice => 'Team point was successfully created.' }
        format.json { render :json => @team_point, :status => :created, :location => @team_point }
      else
        format.html { render :action => "new" }
        format.json { render :json => @team_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_points/1
  # PUT /team_points/1.json
  def update
    @team_point = TeamPoint.find(params[:id])

    respond_to do |format|
      if @team_point.update_attributes(params[:team_point])
        format.html { redirect_to @team_point, :notice => 'Team point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @team_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_points/1
  # DELETE /team_points/1.json
  def destroy
    @team_point = TeamPoint.find(params[:id])
    @team_point.destroy

    respond_to do |format|
      format.html { redirect_to team_points_url }
      format.json { head :no_content }
    end
  end

  def find_all_by_team_id
  end

#--------------------------------------------------authenticate_user---------------------------------------------------------
  # point_list
  #   INPUT: user_id (session value)
  #   OUTPUT: teams (Team.objects)
  #   FROM: /views/teams/point_list
  #   TO: /views/team_points/point_list
  #   2012.7.12 Yueying
  def point_list
    @teams = Team.find_teams_by_user(current_user.id)
  end
end
