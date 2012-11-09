class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name,		:limit => 45

      t.timestamps
    end
  end
end
