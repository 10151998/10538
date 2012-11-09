class SportLevel < ActiveRecord::Base
  # attr_accessible
  attr_accessible :name, :sport_id, :guidence, :number
  
  # dependencies
  has_many :teams, :dependent => :destroy  

  belongs_to :sport

  # functions
  # find_by_user
  #   INPUT: user_id (session value)
  #   OUTPUT: sport_levels (SportLevel.object) list
  #   FROM: controllers/sport_levels_controller/index
  #   2012.6.30 Yueying
  def self.find_by_user(user_id)
    sport_level_ids = SportLevel.find_by_sql("SELECT sport_levels.id FROM teammembers, teams, events, sports, sport_levels WHERE teammembers.user_id = " + user_id.to_s + " AND teammembers.team_id = teams.id AND teams.event_id = events.id AND events.sport_id = sports.id AND sports.id = sport_levels.sport_id ")
    return sport_levels = SportLevel.find_all_by_id(sport_level_ids)
  end
end
