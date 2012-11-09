class Trainer < ActiveRecord::Base
  # dependencies
  has_many :videos, :dependent => :destroy  

  belongs_to :sport

  # attr_accessible  
  attr_accessible :username, :firstname, :lastname, :gender, :sport_id,
                :email, :password, :password_confirmation, :remember_me

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # functions
  # find_by_sport(usre_id)
  #   2012.8.9 Yueying
  def self.find_by_sport(user_id)
    sport_id = Team.find_by_user1(user_id).sport.id
    return trainers = Trainer.find_all_by_sport_id(sport_id)
  end
end
