class TagTopic < ActiveRecord::Base
  validates :tag, presence: true, uniqueness: true

  has_many :urls_join,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :tag_id

  has_many :related_urls,
    through: :urls_join,
    source: :urls

  def most_popular_link
    self.related_urls.max_by(&:num_clicks)
  end
end
