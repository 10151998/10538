class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name,		:limit => 45
      t.string :address,	:limit => 100
      t.string :city,		:limit => 45
      t.string :state,		:limit => 45
      t.integer :zipcode
      t.string :telephone,	:limit => 45

      t.timestamps
    end
  end
end
