class CreateGoal < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :body
      t.boolean :completed
      t.boolean :public
      t.integer :user_id
    end
  end
end
