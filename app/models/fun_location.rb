class FunLocation < ActiveRecord::Base
  # attr_accessible
  attr_accessible :address, :gmaps, :latitude, :longitude, :name

  # dependencies
  has_many :funs, :dependent => :destroy

  # functions
  # find_by_school
  #   2012.6.26, 2012.7.10 Yueying
  def self.find_by_school(user_id)
    school = User.find(user_id).pe_class.school
    fun_location_ids = FunLocation.find_by_sql("SELECT DISTINCT fun_locations.id FROM user_game_preferences, funs, fun_locations WHERE funs.fun_location_id = fun_locations.id AND funs.school_id = " + school.id.to_s)
    fun_locations = FunLocation.find_all_by_id(fun_location_ids)
    # exapt registered all funs at that fun_location
    fun_locations1 = []
    fun_locations.each do |fun_location|
      funs = Fun.find_by_fun_location_school(fun_location.id, user_id)
      funs.each do |fun|
        if !UserFun.find_by_sql("SELECT * FROM user_funs WHERE user_funs.user_id = " + user_id.to_s + " AND user_funs.fun_id = " + fun.id.to_s).any?
          fun_locations1 << fun_location
          break
        end
      end
    end
    return fun_locations1
  end

  # find_by_game_school
  #   INPUT: user_id (session value)
  #   OUTPUT: fun_locations (FunLocation.object)  
  #   FROM: controllers/fun_locations_controller/index
  #   2012.6.26, 2012.7.10 Yueying
  def self.find_by_game_school(user_id)
    school = User.find(user_id).pe_class.school
    fun_location_ids = FunLocation.find_by_sql("SELECT DISTINCT fun_locations.id FROM user_game_preferences, funs, fun_locations WHERE user_game_preferences.user_id = " + user_id.to_s + " AND funs.game_id = user_game_preferences.game_id AND funs.fun_location_id = fun_locations.id AND funs.school_id = " + school.id.to_s)
    fun_locations = FunLocation.find_all_by_id(fun_location_ids)
    # exapt registered all funs at that fun_location
    fun_locations1 = []
    fun_locations.each do |fun_location|
      funs = Fun.find_by_fun_location_school(fun_location.id, user_id)
      funs.each do |fun|
        if !UserFun.find_by_sql("SELECT * FROM user_funs WHERE user_funs.user_id = " + user_id.to_s + " AND user_funs.fun_id = " + fun.id.to_s).any?
          fun_locations1 << fun_location
          break
        end
      end
    end
    return fun_locations1
  end

  # functions for gmaps4rails
  acts_as_gmappable
      def gmaps4rails_address
          address
      end
      
      def gmaps4rails_infowindow
      #add here whatever html content you desire, it will be displayed when users clicks on the marker
      end
end
