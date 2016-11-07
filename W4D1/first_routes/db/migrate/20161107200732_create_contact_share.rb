class CreateContactShare < ActiveRecord::Migration
  def change
    create_table :contact_shares do |t|
      t.integer :contact_id, null: false
      t.integer :user_id, null: false

    end

    add_index :contact_shares, [:contact_id, :user_id]
    add_index :contact_shares, :user_id
  end
end
