class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name,		:limit => 45
      t.integer :user_id
      t.integer :sport_id  
      t.integer :sport_level_id
      t.integer :level_id
      t.string  :is_available,	:default => 1

      t.timestamps
    end
  end
end
