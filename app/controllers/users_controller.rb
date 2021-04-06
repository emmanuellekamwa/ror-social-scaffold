class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending = @user.pending_friends
    @requests = @user.requested_friends
  end

  def update
    @user = User.find(params[:user_id])

    if current_user.confirm_friend(@user)
      redirect_to users_path, notice: 'Friendrequest accepted .'
    else
      redirect_to users_path, alert: 'Oops something went wrong.'
    end
  end

  def destroy
    @user = User.find(params[:user_id])

    if current_user.reject_friend(@user)
      redirect_to users_path, notice: 'Friendrequest rejected'
    else
      redirect_to users_path, alert: 'Oops something went wrong'
    end
  end
end
