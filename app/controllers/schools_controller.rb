
class SchoolsController < ApplicationController

  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.all
    render :layout => nil
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @school = School.find(params[:id])
    render :layout => nil
  end

  # GET /schools/new
  # GET /schools/new.json
  def new
    @school = School.new
    render :layout => nil
  end

  # GET /schools/1/edit
  def edit
    @school = School.find(params[:id])
    render :layout => nil
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(params[:school])

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, :notice => 'School was successfully created.' }
        format.json { render :json => @school, :status => :created, :location => @school }
      else
        format.html { render :action => "new" }
        format.json { render :json => @school.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schools/1
  # PUT /schools/1.json
  def update
    @school = School.find(params[:id])

    respond_to do |format|
      if @school.update_attributes(params[:school])
        format.html { redirect_to @school, :notice => 'School was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @school.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school = School.find(params[:id])
    @school.destroy

    respond_to do |format|
      format.html { redirect_to schools_url }
      format.json { head :no_content }
    end
  end
end
