class PostsController < ApplicationController
  before_action :check_status, only:[:create, :new, :destroy, :edit, :update], unless: :logged_in?

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id

    post.sub_ids = params[:post][:sub_ids].map(&:to_i)

    if post.save
      redirect_to post_url(post)
    else
      flash[:errors] = ["Could not create post"]
      redirect_to sub_url(params[:sub_id])
    end
  end

  def new
    @post = Post.new
    render :new
  end

  def destroy
    post = Post.find(params[:id])

    if post.destroy

    else
      flash[:errors] = ["Could not delete post"]
    end
    redirect_to subs_url
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    post = Post.find(params[:id])

    if post.update(post_params)
    else
      flash[:errors] = ["Could not update post"]
    end

    redirect_to post_url(post)
  end

  def show
    @post = Post.where(id: params[:id]).includes(:comments => [:user]).order("comments.created_at DESC").first
    render :show
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :post_ids => [])
  end
end
