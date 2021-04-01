class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id], status: false)

    if @friendship.save
      redirect_to users_path, notice: 'New invite sent'
    else
      redirect_to users_path, alert: 'Something went wrong'
    end
  end

  def destroy
    @user = User.find(params[:user_id])

    if current_user.friend?(@user)
      redirect_to users_path, notice: 'Invite rejected'
    else
      redirect_to users_path, alert: 'Something went wrong'
    end
  end
end
