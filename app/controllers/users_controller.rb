
class UsersController < ApplicationController
  layout 'dashboard'
  
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_user!, :only => [:render_update_password, :update_password, :render_update_username, :update_username, :render_update_email, :update_email, :render_update_avatar, :update_avatar, :profile, :render_set_account, :set_account, :home]
  before_filter :authenticate_admin!, :only => [:index, :show, :new, :edit, :create, :update, :destroy]

#-----------------------------------------------------authenticate_admin----------------------------------------------------------------  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render :layout => nil
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render :layout => nil
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @pe_classes = PeClass.all
    render :layout => nil
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @pe_classes = PeClass.all
    render :layout => nil
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/imports/new', :notice => 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to '/users' }
      format.json { head :no_content }
    end
  end

#-----------------------------------------------------authenticate_user---------------------------------------------------------------- 
#-----------------------------------------------profile---------------------------------------------
  # render_update_password
  def render_update_password
    @user = User.find(current_user.id)
    render :file => '/users/update_password'
  end

  # update_password
  # devise gem
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-password
  # 2012.7.30 Yueying
  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render ""
    end
  end

  # render_update_username
  #   2012.7.30 Yueying
  def render_update_username
    @user = User.find(current_user.id)
    render :file => '/users/update_username'
  end

  # update_username
  #   2012.7.30 Yueying
  def update_username
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render ""
    end
  end

  # render_update_email
  #   2012.7.30 Yueying
  def render_update_email
    @user = User.find(current_user.id)
    render :file => '/users/update_email'
  end

  # update_email
  #   2012.7.30 Yueying
  def update_email
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render ""
    end
  end

  # render_update_avatar
  #   2012.7.30 Yueying
  def render_update_avatar
    @user = User.find(current_user.id)
    render :file => '/users/update_avatar'
  end

  # update_avatar
  #   2012.7.30 Yueying
  def update_avatar
    @user = User.find(current_user.id)
    if @user.update_attribute(:icon_filename, params[:icon_filename])
      sign_in @user, :bypass => true
      redirect_to '/users/profile'
    else
      redirect_to "/users/render_update_avatar"
    end
  end

  # profile ##top##
  #   FROM: views/teams/home1
  #   INCLUDE VIEWS: /views/users/profile
  #   INCLUDE CONTROLLERS: /controllers/users_controller/profile
  #   2012.7.21 Yueying
  def profile
    # /controllers/users_controller/profile
    flash.delete :notice_email_constrain
    flash.delete :notice_user_constrain    
    @user = User.find(current_user.id)
    render :layout => 'home'
  end

#-----------------------------------------------initial---------------------------------------------
  # render_set_account ##top## 
  #   INPUT:
  #   OUTPUT:
  #   FROM: views/users/sign_in --devise gem
  #   TO: views/users/set_account
  #   2012.7.27 Yueying
  def render_set_account

    # if user.active_code > 0, can't show this page, redirect to home page
    if current_user.active_code > 0
      redirect_to "/teams/home"
    else
      # student information
      @user = current_user
      render :file => '/users/set_account'  
    end
  end

  # set_account ##top## 
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW
  #   FROM: views/users/render_set_account
  #   TO: views/teams/pearup
  #   INCLUDE VIEWS: views/users/confirm_information
  #   INCLUDE CONTROLLERS: controllers/users_controller/confirm_information
  #   2012.7.27 Yueying
  def set_account

    # student information
    @user = current_user

    # avatar galleray
    if params[:commit] == "1"
      @user.update_attribute(:icon_filename, "1")
    elsif params[:commit] == "2"
      @user.update_attribute(:icon_filename, "2")
    elsif params[:commit] == "3"
      @user.update_attribute(:icon_filename, "3")
    elsif params[:commit] == "4"
      @user.update_attribute(:icon_filename, "4")
    elsif params[:commit] == "5"
      @user.update_attribute(:icon_filename, "5")
    elsif params[:commit] == "6"
      @user.update_attribute(:icon_filename, "6")
    # if user.active_code > 0, can't show this page, redirect to home page!!!
    elsif current_user.active_code != 0
      redirect_to "/teams/home"
    # if user didn't complete the form, redirect to current page!!!
    elsif params[:step] == "select steps" or (params[:commit] == nil and current_user.icon_filename == nil) or params[:parental_consent] != 'yes'
      if params[:step] == "select steps"
        flash[:alert_step] = "please select steps"
      end
      if params[:commit] == nil and current_user.icon_filename == nil      
        flash[:alert_avatar] = "please select an avatar"
      end
      if params[:parental_consent] != 'yes'
        flash[:alert_parental_consent] = "please get parental consent"
      end
      redirect_to "/users/render_set_account"
    # else
    elsif params[:parental_consent] == 'yes'
      @user.update_attribute(:step, params[:step])
      @user.update_attribute(:totalSteps, 0)
      @user.update_attribute(:active_code, 1)
      redirect_to "/teams/render_search_team"
    end
  end

#-----------------------------------------------home---------------------------------------------
  # home
  # 2012.7.30 Yueying
  def home
    @user = current_user
    @team = Team.find_by_user1(current_user.id)
    @teammate = Team.find_teammate(current_user.id)
    @user_point = UserPoint.find_by_user1(current_user.id)
    @user_funs = UserFun.find_all_by_user_id(current_user.id)
    render :layout => 'home'
  end
end

#-----------------------------------------------home---------------------------------------------
  # upload
  # 2012.9.18 Jisha
  def upload
    user = User.find(params[:username, :password])
    user.update_attribute(:totalSteps)
  end
