class CreateUserPoints < ActiveRecord::Migration
  def change
    create_table :user_points do |t|
      t.integer :user_id
      t.integer :point_event, :default => 0
      t.integer :point_fun, :default => 0
      t.integer :point_music, :default => 0
      t.integer :point_video, :default => 0

      t.timestamps
    end
  end
end
