class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at

  # dependencies
  has_many :users, :dependent => :destroy 

  #paperclip
  has_attached_file :image,
    :styles => {
      :thumb => "100x100",
      :medium => "200x200",
      :large => "600x400" },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "/:style/:id/:filename",
    :bucket => "theactivegeneration"
end
