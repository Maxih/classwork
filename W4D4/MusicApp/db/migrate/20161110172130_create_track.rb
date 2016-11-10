class CreateTrack < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.integer :album_id, null: false
      t.string :lyrics, null: false
      t.string :track_type, null: false

      t.timestamps
    end

    add_index :tracks, :album_id
  end
end
