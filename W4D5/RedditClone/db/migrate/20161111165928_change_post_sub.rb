class ChangePostSub < ActiveRecord::Migration
  def change
    add_column :post_subs, :post_id, :integer, index: true
    add_column :post_subs, :sub_id, :integer, index: true

    change_column :post_subs, :post_id, :integer, null: false
    change_column :post_subs, :sub_id, :integer, null: false
  end
end
