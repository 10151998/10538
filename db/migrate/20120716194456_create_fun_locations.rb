class CreateFunLocations < ActiveRecord::Migration
  def change
    create_table :fun_locations do |t|
      t.string :name,		:limit => 45
      t.string :address,	:limit => 100
      t.float :longitude
      t.float :latitude
      t.string :gmaps,		:limit => 45

      t.timestamps
    end
  end
end
