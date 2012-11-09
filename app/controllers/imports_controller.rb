
class ImportsController < ApplicationController
  # devise gem
  before_filter :authenticate_admin!

  # layout
  layout false
  
  # GET /imports
  # GET /imports.json
  def index
    @imports = Import.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @imports }
    end
  end

  # GET /imports/1
  # GET /imports/1.json
  def show
    @import = Import.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @import }
    end
  end

  # GET /imports/new
  # GET /imports/new.json
  def new
    @import = Import.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @import }
    end
  end

  # GET /imports/1/edit
  def edit
    @import = Import.find(params[:id])
  end

  # POST /imports
  # POST /imports.json
  def create
    @import = Import.new(params[:import])

    respond_to do |format|
      if @import.save
        format.html { redirect_to @import, notice: 'Import was successfully created.' }
        format.json { render json: @import, status: :created, location: @import }
      else
        format.html { render action: "new" }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /imports/1
  # PUT /imports/1.json
  def update
    @import = Import.find(params[:id])

    respond_to do |format|
      if @import.update_attributes(params[:import])
        format.html { redirect_to @import, notice: 'Import was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imports/1
  # DELETE /imports/1.json
  def destroy
    @import = Import.find(params[:id])
    @import.destroy

    respond_to do |format|
      format.html { redirect_to imports_url }
      format.json { head :no_content }
    end
  end

#-------------------------------------------------------csv file process------------------------------------------------------
  def proc_csv
    @import = Import.find(params[:id])
    lines = parse_csv_file(@import.csv.path)
    lines.shift #comment this line out if your CSV file doesn't contain a header row
    # notice - initial value
    user_notice = nil
    pe_class_notice = nil
    school_notice = nil
    teacher_notice = nil
    trainer_notice = nil
    sport_notice = nil
    sport_level_notice = nil
    game_notice = nil
    fun_notice = nil
    fun_location_notice = nil
    level_notice = nil
    # notice - set value
    if lines.size > 0
      @import.processed = lines.size
      lines.each do |line|
        case @import.datatype
        when "users"
          #new_user(line)
          user_notice = new_user(line)
        when "pe_classes"
          #new_pe_class(line)
          pe_class_notice = new_pe_class(line)
        when "schools"
          #new_school(line)
          school_notice = new_school(line)
        when "teachers"
          #new_teacher(line)
          teacher_notice = new_teacher(line)
        when "trainers"
          #new_trainer(line)
          trainer_notice = new_trainer(line)
        when "sports"
          #new_sport(line)
          sport_notice = new_sport(line)
        when "sport_levels"
          #new_sport_level(line)
          sport_level_notice = new_sport_level(line)
        when "games"
          #new_game(line)
          game_notice = new_game(line)
        when "funs"
          #new_fun(line)
          fun_notice = new_fun(line)
        when "fun_locations"
          #new_fun_location(line)
          fun_location_notice = new_fun_location(line)
        when "levels"
          #new_level(line)
          level_notice = new_level(line)
        end
      end
      @import.save
      flash[:notice] = nil
        # failed
        if user_notice != nil
          flash[:notice] = "#{user_notice.firstname}" + " is saved unsuccessfully, and following items are canceled."
        elsif pe_class_notice != nil
          flash[:notice] = "#{pe_class_notice.name}" + " is saved unsuccessfully, and following items are canceled."
        elsif school_notice != nil
          flash[:notice] = "#{school_notice.name}" + " is saved unsuccessfully, and following items are canceled."
        elsif teacher_notice != nil
          flash[:notice] = "#{teacher_notice.firstname}" + " is saved unsuccessfully, and following items are canceled."
        elsif trainer_notice != nil
          flash[:notice] = "#{trainer_notice.firstname}" + " is saved unsuccessfully, and following items are canceled."
        elsif sport_notice != nil
          flash[:notice] = "#{sport_notice.name}" + " is saved unsuccessfully, and following items are canceled."
        elsif sport_level_notice != nil
          flash[:notice] = "#{sport_level_notice.name}" + " is saved unsuccessfully, and following items are canceled."
        elsif game_notice != nil
          flash[:notice] = "#{game_notice.name}" + " is saved unsuccessfully, and following items are canceled."
        elsif fun_notice != nil
          flash[:notice] = "#{fun_notice.name}" + " is saved unsuccessfully, and following items are canceled."
        elsif fun_location_notice != nil
          flash[:notice] = "#{fun_location_notice.name}" + " is saved unsuccessfully, and following items are canceled."
        elsif level_notice != nil
          flash[:notice] = "#{level_notice.name}" + " is saved unsuccessfully, and following items are canceled."
        # success
        else
          flash[:notice] = "CSV data processing was successful."
        end
      redirect_to :action => "show", :id => @import.id
    else
      flash[:error] = "CSV data processing failed."
      render :action => "show", :id => @import.id
    end
  end

private

  # parse: read csv file
  def parse_csv_file(path_to_csv)
    lines = []
    #if not installed run, sudo gem install fastercsv
    #http://fastercsv.rubyforge.org/
    #require 'fastercsv'
    #FasterCSV.foreach(path_to_csv) do |row|
    require 'csv'
    CSV.foreach(path_to_csv) do |row|
      lines << row
    end
    lines
  end
    
  # release: save records into database
  # correctly
  def new_user(line)
    params = Hash.new
    params[:user] = Hash.new
    params[:user]["email"] = line[1]
    params[:user]["firstname"] = line[14]
    params[:user]["lastname"] = line[15]
    params[:user]["email_parent"] = line[16]
    params[:user]["gender"] = line[17]
    params[:user]["pe_class_id"] = line[18]
    user = User.new(params[:user])
    #  default password = firstname + lastname + lovetag
    user.password = "#{params[:user]["firstname"]}" + "#{params[:user]["lastname"]}" + "lovetag"
    user.username = "#{params[:user]["firstname"]}" + "#{params[:user]["lastname"]}"

    if user.save!
    else
      return user
    end
  end

  # correctly
  def new_pe_class(line)
    params = Hash.new
    params[:pe_class] = Hash.new
    params[:pe_class]["name"] = line[1]
    params[:pe_class]["datetime"] = line[2]
    params[:pe_class]["school_id"] = line[3]
    params[:pe_class]["teacher_id"] = line[4]
    pe_class = PeClass.new(params[:pe_class])

    if pe_class.save!
    else
      return pe_class
    end
  end

  # correctly
  def new_school(line)
    params = Hash.new
    params[:school] = Hash.new
    params[:school]["name"] = line[1]
    params[:school]["address"] = line[2]
    params[:school]["city"] = line[3]
    params[:school]["state"] = line[4]
    params[:school]["zipcode"] = line[5]
    params[:school]["telephone"] = line[6]
    school = School.new(params[:school])

    if school.save! 
    else
      return school
    end
  end

  # correctly
  def new_teacher(line)
    params = Hash.new
    params[:teacher] = Hash.new
    params[:teacher]["email"] = line[1]
    params[:teacher]["firstname"] = line[12]
    params[:teacher]["lastname"] = line[13]
    params[:teacher]["gender"] = line[14]
    params[:teacher]["school_id"] = line[15]
    teacher = Teacher.new(params[:teacher])
    #  default password = firstname + lastname + lovetag
    teacher.password = "#{params[:teacher]["firstname"]}" + "#{params[:teacher]["firstname"]}" + 'lovetag'
    teacher.username = "#{params[:teacher]["firstname"]}" + "#{params[:teacher]["lastname"]}"

    if teacher.save!
    else
      return teacher
    end
  end

  # correctly
  def new_trainer(line)
    params = Hash.new
    params[:trainer] = Hash.new
    params[:trainer]["email"] = line[1]
    params[:trainer]["firstname"] = line[12]
    params[:trainer]["lastname"] = line[13]
    params[:trainer]["gender"] = line[14]
    params[:trainer]["sport_id"] = line[15]
    trainer = Trainer.new(params[:trainer])
    #  default password = firstname + lastname + @ + tag
    trainer.password = "#{params[:trainer]["firstname"]}" + "#{params[:trainer]["firstname"]}" + 'lovetag'
    trainer.username = "#{params[:trainer]["firstname"]}" + "#{params[:trainer]["lastname"]}"

    if trainer.save!
    else
      return trainer
    end
  end

  # correctly
  def new_sport(line)
    params = Hash.new
    params[:sport] = Hash.new
    params[:sport]["name"] = line[1]
    sport = Sport.new(params[:sport])

    if sport.save!
    else
      return sport
    end
  end

  # correctly
  def new_sport_level(line)
    params = Hash.new
    params[:sport_level] = Hash.new
    params[:sport_level]["number"] = line[1]
    params[:sport_level]["name"] = line[2]
    params[:sport_level]["guidence"] = line[3]
    params[:sport_level]["sport_id"] = line[4]
    sport_level = SportLevel.new(params[:sport_level])

    if sport_level.save!
    else
      return sport_level
    end
  end

  # correctly
  def new_game(line)
    params = Hash.new
    params[:game] = Hash.new
    params[:game]["name"] = line[1]
    game = Game.new(params[:game])

    if game.save!
    else
      return game
    end
  end

  # correctly
  def new_fun(line)
    params = Hash.new
    params[:fun] = Hash.new
    params[:fun]["name"] = line[1]
    params[:fun]["game_id"] = line[2]
    params[:fun]["datetime"] = line[3]
    params[:fun]["fun_location_id"] = line[4]
    params[:fun]["popularity"] = line[5]
    params[:fun]["school_id"] = line[6]
    fun = Fun.new(params[:fun])

    if fun.save!
    else
      return fun
    end
  end

  # correctly
  def new_fun_location(line)
    params = Hash.new
    params[:fun_location] = Hash.new
    params[:fun_location]["name"] = line[1]
    params[:fun_location]["address"] = line[2]
    params[:fun_location]["longitude"] = line[3]
    params[:fun_location]["latitude"] = line[4]
    params[:fun_location]["gmaps"] = line[5]
    fun_location = FunLocation.new(params[:fun_location])

    if fun_location.save
    else
      return fun_location
    end
  end

  # correctly
  def new_level(line)
    params = Hash.new
    params[:level] = Hash.new
    params[:level]["name"] = line[1]
    level = Level.new(params[:level])
    if level.save
    else
      return level
    end
  end

  # correctly
  def readme
  end
end
