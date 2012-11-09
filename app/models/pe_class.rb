class PeClass < ActiveRecord::Base
  # attr_accessible
  attr_accessible :datetime, :school_id, :teacher_id, :name
  
  # dependencies
  has_many :pe_classmembers, :dependent => :destroy  
  has_many :users, :dependent => :destroy  

  belongs_to :school
  belongs_to :teacher

  # functions
  # find_news
  #   INPUT: user_id (value)
  #   OUTPUT: activities (Music.object + MusicLike.object + Userfun.object)
  def self.find_news(user_id)
    @musics = Music.find_musics_by_user(user_id)
    @music_likes = MusicLike.find_music_likes_by_user(user_id)
    @user_funs = UserFun.find_by_user1(user_id)
    @activities = @musics + @music_likes + @user_funs

    return activities = @activities.sort_by {|a| a.created_at}
  end

  def pe_classes_for_select
    Pe_class.all.collect {|pe_class| [pe_class.name, pe_class.school.name]}
  end

  # find_teams_by_user, include my team
  #   INPUT: user_id (value)
  #   OUTPUT: teams (Team.object)
  #   FROM: controllers/teams_controller/team_information_list, controllers/team_points_controller/point_list
  #   2012.7.3, 2012.7.11 Yueying
  # exapt user's own team
  def find_all_teams_by_user(user_id)
    user = User.find(user_id)
    pe_class_id = user.pe_class_id
    team_ids = Team.find_by_sql("SELECT teams.id FROM teams, users WHERE teams.user_id = users.id AND users.pe_class_id = " + pe_class_id.to_s)
    return teams_points = TeamPoint.find_all_by_id(team_ids)
  end
end
