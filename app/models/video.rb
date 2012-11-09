class Video < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :video, :video_file_name, :video_content_type, :video_file_size, :sport_id, :trainer_id

  # dependencies
  has_many :users, :dependent => :destroy  

  belongs_to :sport
  belongs_to :trainer
  
  # Paperclip
  # http://www.thoughtbot.com/projects/paperclip
  has_attached_file :video,
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => ":attachment/:id/:style/:basename.:extension",
    :bucket => 'theactivegeneration'

  # Paperclip Validations
  validates_attachment_presence :video
  validates_attachment_content_type :video, :content_type => ['application/x-shockwave-flash', 'application/x-shockwave-flash', 'application/flv', 'video/x-flv', 'video/mp4']

end
