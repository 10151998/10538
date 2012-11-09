class PeClassmember < ActiveRecord::Base
  # attr_accessible
  attr_accessible :pe_class_id, :user_id

  # dependencies
  belongs_to :user
  belongs_to :pe_class
end
