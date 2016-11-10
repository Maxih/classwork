class Album < ActiveRecord::Base
   validates :band_id, :title, :album_type, presence: true
   validates :album_type, inclusion: ['live', 'studio']

   belongs_to :band
   has_many :tracks, dependent: :destroy
end
