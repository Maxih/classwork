class Comment < ActiveRecord::Base
  validates :user_id, :body, :post_id, presence: true

  belongs_to :post
  belongs_to :user
  belongs_to :parent_comment,
    foreign_key: :parent_comment_id,
    primary_key: :id,
    class_name: :Comment

  has_many :child_comments,
    foreign_key: :parent_comment_id,
    primary_key: :id,
    class_name: :Comment
end
