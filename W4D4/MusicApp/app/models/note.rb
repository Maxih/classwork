class Note < ActiveRecord::Base
  validates :user_id, :track_id, :note, presence: true

  belongs_to :user

  belongs_to :track
end
