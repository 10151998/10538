class School < ActiveRecord::Base
  # attr_accessible
  attr_accessible :address, :city, :name, :state, :telephone, :zipcode

  # dependencies
  has_many :teachers, :dependent => :destroy  
  has_many :pe_classes, :dependent => :destroy  
end
