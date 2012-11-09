class CreateChallengeMessages < ActiveRecord::Migration
  def change
    create_table :challenge_messages do |t|
      t.integer :sender_team_id
      t.integer :receiver_team_id
      t.integer :user_id
      t.datetime :datetime
      t.string :location,	:limit => 45
      t.integer :is_read,	:default => 0
      t.integer  :message_type

      t.timestamps
    end
  end
end
