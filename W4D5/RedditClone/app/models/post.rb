# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author, presence: true

  has_many :post_subs
  has_many :subs,
    through: :post_subs

  belongs_to :user
  alias_attribute :author, :user

  has_many :comments
end
