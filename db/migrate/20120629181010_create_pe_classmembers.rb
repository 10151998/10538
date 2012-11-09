class CreatePeClassmembers < ActiveRecord::Migration
  def change
    create_table :pe_classmembers do |t|
      t.integer :pe_class_id
      t.integer :user_id

      t.timestamps
    end
  end
end
