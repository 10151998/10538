class Music < ActiveRecord::Base
  # attr_accessible
  attr_accessible :artist, :name, :popularity, :user_id

  # dependencies
  has_many :music_likes, :dependent => :destroy 

  belongs_to :user

  # functions
  # find_musics_by_user(user_id)
  #   INPUT: user_id (value)
  #   OUTPUT: musics (Music.object)
  #   FROM: controllers/musics_controller/music_list
  #   2012.7.3 Yueying
  def self.find_musics_by_user(user_id)
    user = User.find(user_id)
    pe_class_id = user.pe_class_id
    music_ids = Music.find_by_sql("SELECT musics.id FROM users, musics WHERE users.pe_class_id = " + pe_class_id.to_s + " AND users.id = musics.user_id")
    return musics = Music.find_all_by_id(music_ids)
  end
end
