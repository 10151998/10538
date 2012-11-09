class Game < ActiveRecord::Base
  # attr_accessible
  attr_accessible :name

  # dependencies
  has_many :funs, :dependent => :destroy 
end
