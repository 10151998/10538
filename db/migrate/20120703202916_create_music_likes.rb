class CreateMusicLikes < ActiveRecord::Migration
  def change
    create_table :music_likes do |t|
      t.integer :music_id
      t.integer :user_id

      t.timestamps
    end
  end
end
