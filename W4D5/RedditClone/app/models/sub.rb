# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :string           not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :description, :user, presence: true

  belongs_to :user
  alias_attribute :moderator, :user

  has_many :post_subs
  has_many :posts,
    through: :post_subs

end
