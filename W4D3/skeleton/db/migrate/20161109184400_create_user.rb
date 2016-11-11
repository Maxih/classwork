class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false

    end

    add_index :users, :user_name, unique: true
    add_index :users, :session_token, unique: true
  end
end