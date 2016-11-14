class ChangeGoalsAgain < ActiveRecord::Migration
  def change
    remove_column :goals, :open
    add_column :goals, :viewable, :boolean
  end
end
