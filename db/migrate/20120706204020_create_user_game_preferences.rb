class CreateUserGamePreferences < ActiveRecord::Migration
  def change
    create_table :user_game_preferences do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end
