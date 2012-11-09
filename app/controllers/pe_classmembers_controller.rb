
class PeClassmembersController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!

  # GET /pe_classmembers
  # GET /pe_classmembers.json
  def index
    @pe_classmembers = PeClassmember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pe_classmembers }
    end
  end

  # GET /pe_classmembers/1
  # GET /pe_classmembers/1.json
  def show
    @pe_classmember = PeClassmember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @pe_classmember }
    end
  end

  # GET /pe_classmembers/new
  # GET /pe_classmembers/new.json
  def new
    @pe_classmember = PeClassmember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @pe_classmember }
    end
  end

  # GET /pe_classmembers/1/edit
  def edit
    @pe_classmember = PeClassmember.find(params[:id])
  end

  # POST /pe_classmembers
  # POST /pe_classmembers.json
  def create
    @pe_classmember = PeClassmember.new(params[:pe_classmember])

    respond_to do |format|
      if @pe_classmember.save
        format.html { redirect_to @pe_classmember, :notice => 'Pe classmember was successfully created.' }
        format.json { render :json => @pe_classmember, :status => :created, :location => @pe_classmember }
      else
        format.html { render :action => "new" }
        format.json { render :json => @pe_classmember.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pe_classmembers/1
  # PUT /pe_classmembers/1.json
  def update
    @pe_classmember = PeClassmember.find(params[:id])

    respond_to do |format|
      if @pe_classmember.update_attributes(params[:pe_classmember])
        format.html { redirect_to @pe_classmember, :notice => 'Pe classmember was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @pe_classmember.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pe_classmembers/1
  # DELETE /pe_classmembers/1.json
  def destroy
    @pe_classmember = PeClassmember.find(params[:id])
    @pe_classmember.destroy

    respond_to do |format|
      format.html { redirect_to pe_classmembers_url }
      format.json { head :no_content }
    end
  end
end
