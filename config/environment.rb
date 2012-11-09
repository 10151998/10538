# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tag::Application.initialize!

# email
ActionMailer::Base.smtp_settings = {
  :user_name => "qingdou",
  :password => "iqingdou",
  :domain => "gmail.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
