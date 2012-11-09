class Upload < ActiveRecord::Base
  attr_accessible :tag_steps, :user_id

  # dependencies
  	belongs_to :user_points
 	belongs_to :user

  # functions

end