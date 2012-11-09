class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :source_content_type
      t.string :source_file_name
      t.integer :source_file_size
      t.integer :sport_id
      t.integer :trainer_id

      t.timestamps
    end
  end
end
