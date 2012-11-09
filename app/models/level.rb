class Level < ActiveRecord::Base
  # attr_accessible
  attr_accessible :name
 
  # dependencies
  has_many :teams, :dependent => :destroy 
end
