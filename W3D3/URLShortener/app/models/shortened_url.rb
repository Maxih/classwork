# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  short_url  :string(255)      not null
#  long_url   :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class SpamProtection < ActiveModel::Validator
  def validate(record)
    user = record.submitter
    if user.submitted_urls.where("created_at > '#{1.minute.ago}'").count >= 5 &&
      !user.premium

      record.errors[:image_count] << "Too many submissions in the time period"
    end
  end
end

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true, length: { maximum: 1024 }
  validates :user_id, presence: true
  validates :short_url, presence: true, uniqueness: true

  validates_with SpamProtection

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visitors_join,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :url_id

  has_many :visitors,
    -> { distinct },
    through: :visitors_join,
    source: :users

  has_many :tags_join,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :url_id

  has_many :related_tags,
    through: :tags_join,
    source: :tags

  before_destroy :destroy_associations

  def self.random_code
    code = SecureRandom::urlsafe_base64

    while self.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url, code = nil)
    if code.nil?
      code = ShortenedUrl.random_code
    else
      raise "Not a premium user" unless user.premium
    end

    self.create!(long_url: long_url, short_url: custom_code, user_id: user)
  end

  def self.prune(time)
    timestamp = time.minutes.ago
    ShortenedUrl.where("created_at < '#{timestamp}'").destroy_all
  end

  def num_clicks
    self.visitors_join.select(:user_id).count
  end

  def num_uniques
    self.visitors.select(:id).count
  end

  def num_recent_uniques(timestamp)
    self.visitors_join.where("created_at > '#{timestamp}'").select(:user_id).distinct.count
  end

  def destroy_associations
    # self.tags_join.destroy_all
    # self.visitors_join.destroy_all
  end
end
