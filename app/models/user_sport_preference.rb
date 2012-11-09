class UserSportPreference < ActiveRecord::Base
  # attr_accessible
  attr_accessible :sport_id, :user_id

  # dependencies
  belongs_to :sport 
  belongs_to :user
end
