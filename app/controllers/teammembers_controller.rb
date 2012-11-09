
class TeammembersController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!

  # GET /teammembers
  # GET /teammembers.json
  def index
    @teammembers = Teammember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @teammembers }
    end
  end

  # GET /teammembers/1
  # GET /teammembers/1.json
  def show
    @teammember = Teammember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @teammember }
    end
  end

  # GET /teammembers/new
  # GET /teammembers/new.json
  def new
    @teammember = Teammember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @teammember }
    end
  end

  # GET /teammembers/1/edit
  def edit
    @teammember = Teammember.find(params[:id])
  end

  # POST /teammembers
  # POST /teammembers.json
  def create
    @teammember = Teammember.new(params[:teammember])

    respond_to do |format|
      if @teammember.save
        format.html { redirect_to @teammember, :notice => 'Teammember was successfully created.' }
        format.json { render :json => @teammember, :status => :created, :location => @teammember }
      else
        format.html { render :action => "new" }
        format.json { render :json => @teammember.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teammembers/1
  # PUT /teammembers/1.json
  def update
    @teammember = Teammember.find(params[:id])

    respond_to do |format|
      if @teammember.update_attributes(params[:teammember])
        format.html { redirect_to @teammember, :notice => 'Teammember was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @teammember.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teammembers/1
  # DELETE /teammembers/1.json
  def destroy
    @teammember = Teammember.find(params[:id])
    @teammember.destroy

    respond_to do |format|
      format.html { redirect_to teammembers_url }
      format.json { head :no_content }
    end
  end
end
