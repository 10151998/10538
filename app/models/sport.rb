class Sport < ActiveRecord::Base
  attr_accessible :name

  # dependencies
  has_many :trainer, :dependent => :destroy
  has_many :sport_levels, :dependent => :destroy  
  has_many :user_sport_preferences, :dependent => :destroy  
  has_many :videos, :dependent => :destroy  

end
