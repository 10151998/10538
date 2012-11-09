class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :name,		:limit => 45
      t.string :artist,		:limit => 45
      t.integer :popularity,	:default => 0
      t.integer :user_id

      t.timestamps
    end
  end
end
