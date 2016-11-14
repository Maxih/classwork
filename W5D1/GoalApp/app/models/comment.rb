class Comment < ActiveRecord::Base

  include Commentable 

  belongs_to :commentable, polymorphic: true
end
