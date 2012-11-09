class UserPoint < ActiveRecord::Base
  # attr_accessible
  attr_accessible :point_event, :point_fun, :point_music, :point_video, :user_id

  # dependencies
  belongs_to :user
  
  # functions
  # add_point(user_id, unit_point, point_type)
  #   INPUT: user_id (session value), unit_point, point_type (value)
  #   OUTPUT: SAVE unit_point to point_type
  #   FROM: controllers/music_controller/create
  #   2012.7.12 Yueying
  def add_point(user_id, unit_point, point_type)
    # create/find user_point
    user_point = UserPoint.new
    if UserPoint.find_by_user_id(user_id) == nil
      user_point.user_id = user_id
      user_point.save
    else
      user_point = UserPoint.find_by_user_id(user_id)
    end

    # increase point
    if point_type == 'event'
      new_point = unit_point + user_point.point_event
      user_point.update_attribute(:point_event, new_point)
    elsif point_type == 'fun'
      new_point = unit_point + user_point.point_fun
      user_point.update_attribute(:point_fun, new_point)
    elsif point_type == 'music'
      new_point = unit_point + user_point.point_music
      user_point.update_attribute(:point_music, new_point)
    elsif point_type == 'video'
      new_point = unit_point + user_point.point_video
      user_point.update_attribute(:point_video, new_point)
    elsif point_type == 'steps'
      new_point = unit_point + user_point.point_step
      user_point.update_attribute(:point_step, new_point)
    end
  end
end
