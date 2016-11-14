class ChangeGoal < ActiveRecord::Migration
  def change

    remove_column :goals, :public
    add_column :goals, :open, :boolean

  end
end
