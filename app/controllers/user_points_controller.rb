
class UserPointsController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index, :show, :new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!, :only => [:point_list]

#-------------------------------------------------authenticate_admin-----------------------------------------------
  # GET /user_points
  # GET /user_points.json
  def index
    @user_points = UserPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user_points }
    end
  end

  # GET /user_points/1
  # GET /user_points/1.json
  def show
    @user_point = UserPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user_point }
    end
  end

  # GET /user_points/new
  # GET /user_points/new.json
  def new
    @user_point = UserPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user_point }
    end
  end

  # GET /user_points/1/edit
  def edit
    @user_point = UserPoint.find(params[:id])
  end

  # POST /user_points
  # POST /user_points.json
  def create
    @user_point = UserPoint.new(params[:user_point])

    respond_to do |format|
      if @user_point.save
        format.html { redirect_to @user_point, :notice => 'User point was successfully created.' }
        format.json { render :json => @user_point, :status => :created, :location => @user_point }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_points/1
  # PUT /user_points/1.json
  def update
    @user_point = UserPoint.find(params[:id])

    respond_to do |format|
      if @user_point.update_attributes(params[:user_point])
        format.html { redirect_to @user_point, :notice => 'User point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_points/1
  # DELETE /user_points/1.json
  def destroy
    @user_point = UserPoint.find(params[:id])
    @user_point.destroy

    respond_to do |format|
      format.html { redirect_to user_points_url }
      format.json { head :no_content }
    end
  end

#-----------------------------------------------------authenticate_user----------------------------------------------
  # point_list
  #   INPUT: user_id (session value)
  #   OUTPUT: user_point (UserPoint.object)
  #   FROM: /views/teams/point_list
  #   TO: /views/user_points/point_list
  #   2012.7.12 Yueying
  def point_list
    @user_point = UserPoint.find_by_user_id(current_user.id)
  end
end
