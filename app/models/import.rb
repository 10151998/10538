class Import < ActiveRecord::Base
  # attr_accessible 
  attr_accessible :csv, :datatype, :processed, :csv_file_name, :csv_content_type, :csv_file_size

  # paperclip gem
  has_attached_file :csv
  validates_attachment_presence :csv
  validates_attachment_content_type :csv, :content_type => ['text/csv','text/comma-separated-values','text/csv','application/csv','application/excel','application/vnd.ms-excel','application/vnd.msexcel','text/anytext','text/plain'] 
end
