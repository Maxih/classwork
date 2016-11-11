class CommentsController < ApplicationController
  before_action :check_status, only:[:create, :new, :destroy, :edit, :update], unless: :logged_in?

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
    else
      flash[:errors] = ["Could not create comment"]
    end
    redirect_to post_url(comment.post_id)
  end

  def destroy
    comment = Comment.find(params[:id])
    id = comment.post_id
    if comment.destroy
    else
      flash[:errors] = ["could not delete comment"]
    end
    redirect_to post_url(id)
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
    else
      flash[:errors] = ["Could not update comment"]
    end
    redirect_to post_url(comment.post_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:parent_comment_id, :body, :post_id)
  end

end
