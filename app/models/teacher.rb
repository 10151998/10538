class Teacher < ActiveRecord::Base
  # dependencies
  has_many :pe_classes, :dependent => :destroy  

  belongs_to :school

  # attr_accessible
  attr_accessible :username, :firstname, :lastname, :gender, :school_id,
                :email, :password, :password_confirmation, :remember_me

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # functions

end
