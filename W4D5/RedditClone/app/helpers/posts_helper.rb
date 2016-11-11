module PostsHelper
  def comments
    comment_hash = Hash.new()
    comments = @post.comments

    comments.each do |comment|
      comment_hash[comment.parent_comment_id] = [] unless comment_hash[comment.parent_comment_id]
      comment_hash[comment.parent_comment_id] << comment
    end

    render 'comment', hash: comment_hash, key: nil, num: 1
  end
end
