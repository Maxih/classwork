class CreateAlbum < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :title, null: false
      t.string :album_type, null: false

      t.timestamps
    end
  end
end
