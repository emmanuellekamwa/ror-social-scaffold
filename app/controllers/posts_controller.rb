class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    ids = [current_user.id]
    ids << current_user.friends.ids
    ids.flatten!
    @timeline_posts ||= Post.all.ordered_by_most_recent.where('user_id IN (?)', ids)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
