class CreateConstants < ActiveRecord::Migration
  def change
    create_table :constants do |t|
      t.string :name,		:limit => 45
      t.string :value,		:limit => 45

      t.timestamps
    end
  end
end
