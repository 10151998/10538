
class VideosController < ApplicationController
  # devise gem
  before_filter :authenticate_trainer!, :only => [:index, :show, :new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!, :only => [:user_video_list]

#-----------------------------------------------------authenticate_trainer---------------------------------------------------------------- 

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
    render :layout => nil
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
    render :layout => nil
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new
    render :layout => nil
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
    render :layout => nil
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(params[:video])
    @video.sport_id = current_trainer.sport.id
    @video.trainer_id = current_trainer.id

    respond_to do |format|
      if @video.save!
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

#-----------------------------------------------------authenticate_user---------------------------------------------------------------- 

  def user_video_list
    @videos = Video.all
  end
end
