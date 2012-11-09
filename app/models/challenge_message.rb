class ChallengeMessage < ActiveRecord::Base
  # attr_accessible
  attr_accessible :datetime, :location, :receiver_team_id, :sender_team_id, :user_id, :message_type, :is_read
  
  # dependencies
  belongs_to :user

  # functions
  # find_inbox_by_user(user_id)
  #   INPUT: user_id (value: receiver)
  #   OUTPUT: challenge_messages (ChallengeMessage.objects)
  #   FROM: /controllers/challenge_messages_controller/inbox_list
  #   2012.7.12 Yueying
  def self.find_inbox_by_user(user_id)
    team = Team.find_by_user1(user_id)
    challenge_message_ids = ChallengeMessage.find_by_sql("SELECT challenge_messages.id FROM challenge_messages WHERE challenge_messages.receiver_team_id = "+ team.id.to_s)
    return challenge_messages = ChallengeMessage.find_all_by_id(challenge_message_ids)
  end

  # find_sentbox_by_user(user_id)
  #   INPUT: user_id (value: receiver)
  #   OUTPUT: challenge_messages (ChallengeMessage.objects)
  #   FROM: /controllers/challenge_messages_controller/sentbox_list
  #   2012.7.12 Yueying
  def self.find_sentbox_by_user(user_id)
    team = Team.find_by_user1(user_id)
    challenge_message_ids = ChallengeMessage.find_by_sql("SELECT challenge_messages.id FROM challenge_messages WHERE challenge_messages.sender_team_id = "+ team.id.to_s)
    return challenge_messages = ChallengeMessage.find_all_by_id(challenge_message_ids)
  end

end
