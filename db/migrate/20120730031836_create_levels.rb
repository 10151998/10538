class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name, :limit => 45

      t.timestamps
    end
  end
end
