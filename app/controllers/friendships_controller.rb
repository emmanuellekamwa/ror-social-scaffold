class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id], confirmed: false)

    if @friendship.save
      redirect_to users_path, notice: 'New invite sent.'
    else
      redirect_to users_path, alert: 'Oops something went wrong!'
    end
  end

  def destroy
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])
    @invert_friendship = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)

    if @invert_friendship.nil?
      @friendship.destroy
      redirect_to request.referrer, notice: 'Friendship invite cancelled!'
    else
      @invert_friendship.destroy
      @friendship.destroy
      redirect_to request.referrer, notice: 'Unfriended the friend'
    end
  end
end
