
class MusicsController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create, :music_list, :home]

#----------------------------------------------------authenticate_admin------------------------------------------------
  # GET /musics
  # GET /musics.json
  def index
    @musics = Music.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @musics }
    end
  end

  # GET /musics/1
  # GET /musics/1.json
  def show
    @music = Music.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @music }
    end
  end

   # GET /musics/1/edit
  def edit
    music = Music.find(params[:id])
  end

  # PUT /musics/1
  # PUT /musics/1.json
  def update
    @music = Music.find(params[:id])

    respond_to do |format|
      if @music.update_attributes(params[:music])
        format.html { redirect_to @music, :notice => 'Music was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @music.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /musics/1
  # DELETE /musics/1.json
  def destroy
    @music = Music.find(params[:id])
    @music.destroy

    respond_to do |format|
      format.html { redirect_to musics_url }
      format.json { head :no_content }
    end
  end

#----------------------------------------------------authenticate_user------------------------------------------------
  # GET /musics/new
  # GET /musics/new.json
  def new
    @music = Music.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @music }
    end
    
  end

  # POST /musics
  # POST /musics.json
  # create
  #   INPUT: user_id (session value), name, artist (value)
  #   OUTPUT: SAVE music (Music.object)
  #   FROM: /views/musics/_form
  #   TO:
  #   2012.7.6 Yueying
  def create
    # save music
    @music = Music.new(params[:music])
    @music.user_id = current_user.id
    if Music.find_by_sql("SELECT * FROM musics WHERE musics.name = '" + @music.name + "' AND musics.artist = '" + @music.artist + "'").any?
      flash[:notice] = "This music is already there!"
      flash.now
      redirect_to :controller => 'musics', :action => 'new', :notice => "This music is already there!"
    else
      @music.save

      # save user_point
      user_point = UserPoint.new
      user_point.add_point(current_user.id, 5000, 'music')

      # save team_point
      team_point = TeamPoint.new
      team = Team.find_by_user1(current_user.id)
      team_point.add_point(team.id, 5000)

      redirect_to '/musics/home'
    end
  end


  # music_list
  #   INPUT: user_id (session value)
  #   OUTPUT: SHOW music (Music.object), SAVE music_like
  #   FROM: views/classes/home
  #   TO: views/musics/music_list
  #   2012.7.3 Yueying
  def music_list
    @musics = Music.find_musics_by_user(current_user.id)
     
    music_like = MusicLike.new
    music_like.user_id = current_user.id
    hash = params[:like]
    if  hash != nil
      hash_invert = hash.invert
      music_like.music_id = hash_invert.values_at("like").first.to_i
      music_like.save

      music = music_like.music
      sql = ActiveRecord::Base.connection()
      sql.execute("UPDATE musics SET musics.popularity = musics.popularity + 1 WHERE musics.id = " + music.id.to_s)
    end
    
    redirect_to '/musics/home'
  end

#--------------------------------------------------home--------------------------------------------
  # home ##top##
  #   FROM: views/musics/home1
  #   INCLUDE VIEWS: /views/musics/create, /views/musics/music_list
  #   INCLUDE CONTROLLERS: /controllers/musics_controller/create, /controllers/musics_controller/music_list
  #   2012.7.21 Yueying
  def home
    # /controllers/musics_controller/music_list
    @musics = Music.find_musics_by_user(current_user.id)
     
    music_like = MusicLike.new
    music_like.user_id = current_user.id
    hash = params[:like]
    if  hash != nil
      hash_invert = hash.invert
      music_like.music_id = hash_invert.values_at("like").first.to_i
      music_like.save

      music = music_like.music
      sql = ActiveRecord::Base.connection()
      sql.execute("UPDATE musics SET musics.popularity = musics.popularity + 1 WHERE musics.id = " + music.id.to_s)
    end

  end
end
