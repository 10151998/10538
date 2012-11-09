class Fun < ActiveRecord::Base
  # attr_accessible
  attr_accessible :datetime, :fun_location_id, :name, :game_id, :popularity, :school_id

  # dependencies
  has_many :user_funs, :dependent => :destroy 

  belongs_to :game
  belongs_to :fun_location

  # functions
  # find_funs_by_game_peclass(user_id)
  #   INPUT: user_id (session value)  
  #   OUTPUT: funs (Fun.object)
  #   FROM: controllers/fun_locations_controller/index
  #   2012.7.16 Yueying
  # not include registered funs
  # not include unavailable funs
  def self.find_by_game_fun_location_school(fun_location_id, user_id)
      school = User.find(user_id).pe_class.school 
      fun_ids = Fun.find_by_sql("SELECT funs.id FROM user_game_preferences, games, funs, users WHERE user_game_preferences.user_id = " + user_id.to_s + " AND games.id = user_game_preferences.game_id AND funs.game_id = games.id AND funs.school_id = " + school.id.to_s + " AND funs.fun_location_id = " + fun_location_id.to_s + " AND funs.is_available = 1")
      # exapt registered funs
      funs = Fun.find_all_by_id(fun_ids)
      funs1 = []
      funs.each do |fun|
        if !UserFun.find_by_sql("SELECT * FROM user_funs WHERE user_id = " + user_id.to_s + " AND fun_id = " + fun.id.to_s).any? 
        funs1 << fun
        end
      end
      return funs1
  end

  # find_funs_by_game_peclass(user_id)
  #   2012.8.9 Yueying
  # not include registered funs
  # not include unavailable funs
  def self.find_by_fun_location_school(fun_location_id, user_id)
      school = User.find(user_id).pe_class.school 
      fun_ids = Fun.find_by_sql("SELECT funs.id FROM funs, users WHERE funs.school_id = " + school.id.to_s + " AND funs.fun_location_id = " + fun_location_id.to_s + " AND funs.is_available = 1")
      # exapt registered funs
      funs = Fun.find_all_by_id(fun_ids)
      funs1 = []
      funs.each do |fun|
        if !UserFun.find_by_sql("SELECT * FROM user_funs WHERE user_id = " + user_id.to_s + " AND fun_id = " + fun.id.to_s).any? 
        funs1 << fun
        end
      end
      return funs1
  end
  
end
