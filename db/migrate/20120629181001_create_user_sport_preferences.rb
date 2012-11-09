class CreateUserSportPreferences < ActiveRecord::Migration
  def change
    create_table :user_sport_preferences do |t|
      t.integer :user_id
      t.integer :sport_id

      t.timestamps
    end
  end
end
