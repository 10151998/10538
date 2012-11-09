class CreateSportLevels < ActiveRecord::Migration
  def change
    create_table :sport_levels do |t|
      t.integer :number
      t.string :name,		:limit => 45
      t.string :guidence, 	:limit => 1000
      t.integer :sport_id

      t.timestamps
    end
  end
end
