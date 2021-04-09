module UsersHelper
  def timeline_posts(post)
    return unless current_user.friends.include?(post.user)
  end

  def friends
    render 'friends'
  end

  def delete_friend(friend)
    return unless current_user?

    link_to 'Delete', friendship_path(user_id: current_user, friend_id: friend), method: :delete, class: 'btn btn-war
      ning'
  end

  def requested_friends
    render 'requested_friends' if current_user?
  end

  def pending_friends
    render 'pending_friends' if current_user?
  end

  private

  def current_user?
    @user == current_user
  end
end
