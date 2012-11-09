class CreateTeamChallenges < ActiveRecord::Migration
  def change
    create_table :team_challenges do |t|
      t.integer :sender_team_id
      t.integer :receiver_team_id
      t.datetime :datetime
      t.string :location,	:limit => 45

      t.timestamps
    end
  end
end
