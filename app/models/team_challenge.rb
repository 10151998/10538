class TeamChallenge < ActiveRecord::Base
  # attr_accessible
  attr_accessible :datetime, :location, :receiver_team_id, :sender_team_id

  # functions
  # find_by_user(user_id)
  #   INPUT: user_id (session value)
  #   OUTPUT: team_challenges (TeamChallenge.objects)
  #   FROM: controllers/team_challenges_controller/team_challenge_list
  #   2012.7.15 Yueying
  def self.find_by_user(user_id)
    team = Team.find_by_user1(user_id)
    challenge_message_ids = TeamChallenge.find_by_sql("SELECT team_challenges.id FROM team_challenges WHERE team_challenges.receiver_team_id = " + team.id.to_s + " OR team_challenges.sender_team_id = " + team.id.to_s)
    return challenge_messages = TeamChallenge.find_all_by_id(challenge_message_ids)
  end
end
