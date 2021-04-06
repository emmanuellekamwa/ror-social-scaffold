class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Check to find out if there exist between these two
  def self.exist?(user, friend)
    !find_by_user_id_and_friend_id(user, friend).nil?
  end

  #  For sending friend rquests
  def self.request(user, friend)
    return if user == friend || Friendship.exist?(user, friend)

    transaction do
      create(user: user, friend: friend, status: 'pending')
      create(user: friend, friend: user, status: 'requested')
    end
  end
end