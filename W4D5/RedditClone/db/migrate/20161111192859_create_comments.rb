class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false, index: true
      t.string :body, null: false
      t.integer :post_id, null: false, index: true
      t.integer :parent_comment_id, index: true

      t.timestamps null: false
    end
  end
end
