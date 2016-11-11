# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ActiveRecord::Base
  validates :sub, :post, presence: true

  belongs_to :sub
  belongs_to :post
end
