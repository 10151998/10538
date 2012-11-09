class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :datatype, :limit => 45
      t.integer :processed, :default => 0
      t.string :csv_file_name, :limit => 200
      t.string :csv_content_type, :limit => 45
      t.integer :csv_file_size 

      t.timestamps
    end
  end
end
