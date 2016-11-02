# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  url_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Visit < ActiveRecord::Base
  validates :user_id, :url_id, presence: true

  has_many :users,
    class_name: :User,
    primary_key: :user_id,
    foreign_key: :id

  has_many :urls,
    class_name: :ShortenedUrl,
    primary_key: :url_id,
    foreign_key: :id

  def self.record_visit!(user, shortened_url)
    self.create!(user_id: user.id, url_id: shortened_url.id)
  end

end
