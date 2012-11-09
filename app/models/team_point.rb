class TeamPoint < ActiveRecord::Base
  # attr_accessible
  attr_accessible :point_of_week, :team_id

  # dependencies
  belongs_to :team
  
  # functions
  # add_point(team_id, unit_point)
  #   INPUT: team_id, unit_point (value)
  #   OUTPUT: SAVE unit_point to point_type
  #   FROM: controllers/music_controller/create
  #   2012.7.12 Yueying
  def add_point(team_id, unit_point)
    # create/find team_point
    team_point = TeamPoint.new
    # 1. create team_point: 1st 
    if TeamPoint.find_by_team_id(team_id) == nil
      team_point.team_id = team_id
      team_point.save
    # 2. find team_point: last 
    else
      team_points = TeamPoint.find_all_by_team_id(team_id)
      team_point = team_points.last
      # if new week, create team_point
      time_last_updated_at = TeamPoint.find(team_point.id).updated_at
      #time_initial_week_string = Constant.find(:all, :conditions => ["name =?", 'initial_week']).first.value
      #time_initial_week = DateTime.strptime(time_initial_week_string, "%Y-%m-%d %H:%M:%S")
      time_beginning_of_week = DateTime.now.at_beginning_of_week
      if time_last_updated_at < time_beginning_of_week
        team_point.team_id = team_id
        team_point.save
      end
    end

    # increase point_of_week
    new_point = unit_point + team_point.point_of_week
    team_point.update_attribute(:point_of_week, new_point)
  end

  def self.find_all_by_team_id
    team_points = TeamPoint.find_all_by_team_id(team_id)
    team_point = team_points.sum
  end
end
