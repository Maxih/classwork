class CreateTagTopic < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :tag, null: false, unique: true

      t.timestamps
    end
  end
end
