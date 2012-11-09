
class UserFunsController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index, :show, :new, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:create, :attend]

#------------------------------------------------authenticate_admin-----------------------------------------------
  # GET /user_funs
  # GET /user_funs.json
  def index
    @user_funs = UserFun.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user_funs }
    end
  end

  # GET /user_funs/1
  # GET /user_funs/1.json
  def show
    @user_fun = UserFun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user_fun }
    end
  end

  # GET /user_funs/new
  # GET /user_funs/new.json
  def new
    @user_fun = UserFun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user_fun }
    end
  end

  # GET /user_funs/1/edit
  def edit
    @user_fun = UserFun.find(params[:id])
  end

  # PUT /user_funs/1
  # PUT /user_funs/1.json
  def update
    @user_fun = UserFun.find(params[:id])

    respond_to do |format|
      if @user_fun.update_attributes(params[:user_fun])
        format.html { redirect_to @user_fun, :notice => 'User fun was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user_fun.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_funs/1
  # DELETE /user_funs/1.json
  def destroy
    @user_fun = UserFun.find(params[:id])
    @user_fun.destroy

    respond_to do |format|
      format.html { redirect_to user_funs_url }
      format.json { head :no_content }
    end
  end

#------------------------------------------------authenticate_user-----------------------------------------------
#-------------------------------------------------register fun---------------------------------------------------
  # POST /user_funs
  # POST /user_funs.json
  # create
  #   INPUT: fun_id (value)
  #   OUTPUT: SAVE user_fun (UserFun.object), fun.popularity +1
  #   FROM: views/funs/list_selected
  #   TO: 
  #   2012.7.6 Yueying
  def create
    hash = params[:register]

    if  hash != nil
      user_fun = UserFun.new
      user_fun.user_id = current_user.id
      hash_invert = hash.invert
      user_fun.fun_id = hash_invert.values_at("register").first.to_i
      user_fun.save

      fun = user_fun.fun
      sql = ActiveRecord::Base.connection()
      sql.execute("UPDATE funs SET funs.popularity = funs.popularity + 1 WHERE funs.id = " + fun.id.to_s)
    end

    respond_to do |format|
      format.html { redirect_to '/users/home' }
    end
  end

#--------------------------------------------------------attend fun----------------------------------------
  # attend
  #   INPUT: user_fun_id (value), user_id (session value)
  #   OUTPUT: SAVE user_point, team_point, user_fun.attend
  #   FROM: /views/funs/my_fun_list
  #   TO: 
  #   2012.7.17 Yueying
  def attend
    # update user_fun.is_attend
    user_fun = UserFun.find(params[:user_fun_id])
    user_fun.update_attribute(:is_attend, 1)

    # save user_point
    user_point = UserPoint.new
    user_point.add_point(current_user.id, 30000, 'fun')
   
    # save team_point 
    team_point = TeamPoint.new
    team = Team.find_by_user1(current_user.id)
    team_point.add_point(team.id, 30000)

    redirect_to '/users/home'
  end
end
