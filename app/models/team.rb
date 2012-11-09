class Team < ActiveRecord::Base
  # attr_accessible
  attr_accessible :name, :user_id, :sport_id, :level_id, :sport_level_id

  # dependencies
  has_many :teammembers, :dependent => :destroy  
  has_many :team_points, :dependent => :destroy  

  belongs_to :sport
  belongs_to :level
  belongs_to :sport_level
  belongs_to :user

  # functions
  # find_by_user1
  #   INPUT: user_id (value)
  #   OUTPUT: team (Team.object)
  #   FROM: controllers/teams_controller/team_information
  #   2012.6.29 Yueying
  def self.find_by_user1(user_id)
    team_id = Team.find_by_sql("SELECT teams.id FROM teammembers, teams WHERE " + user_id.to_s + " = teammembers.user_id AND teammembers.team_id = teams.id")
    return team = Team.find_by_id(team_id)
  end

  # find_teammate 
  #   INPUT: user_id (value)
  #   OUTPUT: user (User: object)
  #   FROM: controllers/teams_controller/team_information
  #   2012.6.29 Yueying
  def self.find_teammate(user_id)
    team_id = Team.find_by_sql("SELECT teammembers.team_id FROM teammembers WHERE teammembers.user_id = " + user_id.to_s)
    user_id1 = Team.find_by_sql("SELECT users.id FROM teammembers, users WHERE teammembers.team_id = team_id AND teammembers.user_id != " + user_id.to_s + " AND teammembers.user_id = users.id ")
    return user = User.find_by_id(user_id1)
  end

  # find_teamowner!!!!!!!!!!!!!!!!!!!!!!!!!!!!can be deleted after modified
  #   INPUT: team_id (value)
  #   OUTPUT: user (User: object)
  #   FROM: controllers/teams_controller/teamowner_information
  #   2012.6.29 Yueying
  def self.find_teamowner(team_id)
    user_id = Team.find_by_sql("SELECT users.id FROM teams, users WHERE teams.id = " + team_id.to_s + " AND teams.user_id = users.id")
    return user = User.find_by_id(user_id)
  end

  # find_teams_by_user, include my team
  #   INPUT: user_id (value)
  #   OUTPUT: teams (Team.object)
  #   FROM: controllers/teams_controller/team_information_list, controllers/team_points_controller/point_list
  #   2012.7.3, 2012.7.11 Yueying
  # exapt user's own team
  def self.find_teams_by_user(user_id)
    user = User.find(user_id)
    pe_class_id = user.pe_class_id
    team_from_user = Team.find_by_user1(user_id)
    team_ids = Team.find_by_sql("SELECT teams.id FROM teams, users WHERE teams.user_id = users.id AND users.pe_class_id = " + pe_class_id.to_s + " AND teams.id != " + team_from_user.id.to_s)
    return teams = Team.find_all_by_id(team_ids)
  end

  # find_available_by_sport_and_level(level_id)
  #   FROM: controllers/teams_controller/render_search_team
  #   2012.7.30 Yueying
  def self.find_available_by_sport_and_level(user_id, level_id)
    user = User.find(user_id)
    sport_id = UserSportPreference.find_by_user_id(user_id).sport_id
    team_from_user = Team.find_by_user1(user_id)
    team_ids = Team.find_by_sql("SELECT teams.id FROM teams WHERE teams.level_id = " + level_id.to_s + " AND teams.sport_id = " + sport_id.to_s + " AND teams.is_available = 1 AND teams.id != " + team_from_user.id.to_s)
    return teams = Team.find_all_by_id(team_ids)
  end

  # find_available_by_sport(level_id)
  #   FROM: controllers/teams_controller/render_search_team
  #   2012.7.30 Yueying
  def self.find_available_by_sport(user_id)
    sport_id = UserSportPreference.find_by_user_id(user_id).sport_id
    team_from_user = Team.find_by_user1(user_id)
    team_ids = Team.find_by_sql("SELECT teams.id FROM teams WHERE teams.sport_id = " + sport_id.to_s + " AND teams.is_available = 1 AND teams.id != " + team_from_user.id.to_s)
    return teams = Team.find_all_by_id(team_ids)
  end
end
