class CreateMentorMessages < ActiveRecord::Migration
  def change
    create_table :mentor_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string	:subject
      t.string	:content
      t.integer :is_read,	:default => 0
      t.integer :message_type

      t.timestamps
    end
  end
end
