class CreateTeamPoints < ActiveRecord::Migration
  def change
    create_table :team_points do |t|
      t.integer :team_id
      t.integer :point_of_week

      t.timestamps
    end
  end
end
