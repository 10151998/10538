class User < ActiveRecord::Base
  # dependencies
  has_many :user_sport_preferences, :dependent => :destroy 
  has_many :teammembers, :dependent => :destroy  
  has_many :pe_classmembers, :dependent => :destroy  
  has_many :musics, :dependent => :destroy  
  has_many :music_likes, :dependent => :destroy  
  has_many :user_funs, :dependent => :destroy  
  has_many :teams, :dependent => :destroy  
  has_many :user_points, :dependent => :destroy  
  has_many :challenge_messages, :dependent => :destroy  

  belongs_to :pe_class 
  belongs_to :image

  # attr_accessible :URL variable changeable
  attr_accessible :username, :firstname, :lastname, :email_parent, :gender, :pe_class_id,
                :active_code, :step, :icon_filename,
                :email, :password, :password_confirmation, :remember_me

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # functions
  def pe_classes_for_select
    Pe_class.all.collect {|pe_class| [pe_class.name, pe_class.school.name]}
  end
end
