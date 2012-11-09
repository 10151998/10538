class MentorMessage < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :sender_id, :receiver_id, :message_type, :is_read, :subject, :content

  # functions
  # find_by_user(user_id)
  def self.find_inbox_by_user(user_id)
    mentor_message_ids = MentorMessage.find_by_sql("SELECT mentor_messages.id FROM mentor_messages WHERE mentor_messages.receiver_id = " + user_id.to_s + " AND mentor_messages.message_type = 1")
    return mentor_messages = MentorMessage.find(mentor_message_ids)
  end

  # find_by_user(user_id)
  def self.find_sentbox_by_user(user_id)
    mentor_message_ids = MentorMessage.find_by_sql("SELECT mentor_messages.id FROM mentor_messages WHERE mentor_messages.sender_id = " + user_id.to_s + " AND mentor_messages.message_type = 0")
    return mentor_messages = MentorMessage.find_all_by_id(mentor_message_ids)
  end
end
