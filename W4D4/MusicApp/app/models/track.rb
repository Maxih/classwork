class Track < ActiveRecord::Base
  validates :album_id, :title, :track_type, :lyrics, null: false
  validates :track_type, inclusion: ['bonus', 'regular']

  belongs_to :album
  has_one :band,
    through: :album,
    source: :band

  has_many :notes

  def ugly_lyrics
    self.lyrics.split("\n").map {|line| "<pre>&#9835 #{line}</pre>"}.join.html_safe
  end
end
