
class MusicLikesController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!

  # GET /music_likes
  # GET /music_likes.json
  def index
    @music_likes = MusicLike.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @music_likes }
    end
  end

  # GET /music_likes/1
  # GET /music_likes/1.json
  def show
    @music_like = MusicLike.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @music_like }
    end
  end

  # GET /music_likes/new
  # GET /music_likes/new.json
  def new
    @music_like = MusicLike.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @music_like }
    end
  end

  # GET /music_likes/1/edit
  def edit
    @music_like = MusicLike.find(params[:id])
  end

  # POST /music_likes
  # POST /music_likes.json
  def create
    @music_like = MusicLike.new(params[:music_like])

    respond_to do |format|
      if @music_like.save
        format.html { redirect_to @music_like, :notice => 'Music like was successfully created.' }
        format.json { render :json => @music_like, :status => :created, :location => @music_like }
      else
        format.html { render :action => "new" }
        format.json { render :json => @music_like.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /music_likes/1
  # PUT /music_likes/1.json
  def update
    @music_like = MusicLike.find(params[:id])

    respond_to do |format|
      if @music_like.update_attributes(params[:music_like])
        format.html { redirect_to @music_like, :notice => 'Music like was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @music_like.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /music_likes/1
  # DELETE /music_likes/1.json
  def destroy
    @music_like = MusicLike.find(params[:id])
    @music_like.destroy

    respond_to do |format|
      format.html { redirect_to music_likes_url }
      format.json { head :no_content }
    end
  end
end
