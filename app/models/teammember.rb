class Teammember < ActiveRecord::Base
  # attr_accessible
  attr_accessible :team_id, :user_id

  # dependencies
  belongs_to :team
  belongs_to :user

  # functions

end
