class CreateFuns < ActiveRecord::Migration
  def change
    create_table :funs do |t|
      t.string :name,		:limit => 45
      t.integer :game_id
      t.datetime :datetime
      t.integer :fun_location_id
      t.integer :popularity,	:default => 0
      t.integer :school_id
      t.integer :is_available, :default => 1

      t.timestamps
    end
  end
end
