class MusicLike < ActiveRecord::Base
  # attr_accessible
  attr_accessible :music_id, :user_id

  # dependencies
  belongs_to :user
  belongs_to :music

  # functions
  # find_music_likes_by_user(user_id)
  #   INPUT: user_id (value)
  #   OUTPUT: music_likes (MusicLike.object)
  #   FROM: models/pe_class/find_news
  #   2012.7.5 Yueying
  def self.find_music_likes_by_user(user_id)
    user = User.find(user_id)
    pe_class_id = user.pe_class_id
    music_like_ids = MusicLike.find_by_sql("SELECT music_likes.id FROM users, music_likes WHERE users.pe_class_id = " + pe_class_id.to_s + " AND users.id = music_likes.user_id")
    return music_likes = MusicLike.find_all_by_id(music_like_ids)
  end
end
