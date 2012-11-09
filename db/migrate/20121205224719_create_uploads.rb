class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :user_id
      t.integer :tag_steps

      t.timestamps
    end
  end
end
