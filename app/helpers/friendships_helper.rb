module FriendshipsHelper
  private

  def mutual_friends(user1, user2)
    user1.friends & user2.friends
  end
end
