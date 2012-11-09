class UserFun < ActiveRecord::Base
  # attr_accessible
  attr_accessible :fun_id, :user_id
 
  # dependencies
  belongs_to :fun
  belongs_to :user

  # functions
  # find_by_user1(user_id)
  #   INPUT: user_id (value)
  #   OUTPUT: user_funs (UserFun.object)
  #   FROM: models/pe_class/find_news
  #   2012.7.5 Yueying
  def self.find_by_user1(user_id)
    user = User.find(user_id)
    pe_class_id = user.pe_class_id
    user_fun_ids = UserFun.find_by_sql("SELECT user_funs.id FROM users, user_funs WHERE users.pe_class_id = " + pe_class_id.to_s + " AND users.id = user_funs.user_id")
    return user_funs = UserFun.find_all_by_id(user_fun_ids)
  end
end
