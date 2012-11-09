class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

      t.string :username,	:limit => 45
      t.string :firstname,	:limit => 45
      t.string :lastname,	:limit => 45
      t.string :email_parent,	:limit => 45
      t.string :gender,		:limit => 45
      t.integer :pe_class_id
      t.integer :active_code, 	:default => 0
      t.integer :step, 	:default => 0
      t.integer :totalSteps, 	:default => 0
      t.string  :icon_filename
      t.integer :image_id

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :user1s, :confirmation_token,   :unique => true
    # add_index :user1s, :unlock_token,         :unique => true
    # add_index :user1s, :authentication_token, :unique => true
  end
end
