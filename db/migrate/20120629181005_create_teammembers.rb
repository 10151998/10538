class CreateTeammembers < ActiveRecord::Migration
  def change
    create_table :teammembers do |t|
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
