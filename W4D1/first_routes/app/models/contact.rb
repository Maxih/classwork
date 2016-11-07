class Contact < ActiveRecord::Base
  validates :email, :user_id, :name, presence: true

  belongs_to :owner,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :contact_shares, dependent: :destroy,
    class_name: :ContactShare,
    primary_key: :id,
    foreign_key: :contact_id

  has_many :shared_users,
    through: :contact_shares,
    source: :user

  has_many :comments,
    as: :commentable
end
