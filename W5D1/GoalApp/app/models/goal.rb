class Goal < ActiveRecord::Base

  validates :body, :completed, :viewable, :user, presence: true

  belongs_to :user
  include Commentable

end
