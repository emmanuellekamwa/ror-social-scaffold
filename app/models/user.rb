class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :friends, -> { where('status = ?', 'accepted') }, through: :friendships, source: :friend

  has_many :requested_friends, -> { where('status = ?', 'requested') }, through: :friendships, source: :friend
  has_many :pending_friends, -> { where('status = ?', 'pending') }, through: :friendships, source: :friend

  def reject_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def friends_and_own_posts
    Post.where(user_id: friends_ids)
  end

  def friend?(user)
    friends.include?(user)
  end

  def user_friend
    f = friends.map(&:id)
    f << id
    Post.all.where(user_id: f)
  end

  def mutual_friends(other_user)
    mutual_friends = []

    if self != other_user
      my_friends = friends
      other_friends = other_user.friends
      other_friends.each do |j|
        mutual_friends << j if my_friends.include?(j)
      end
    end

    mutual_friends
  end

  def friends_ids
    f_ids = friends.map(&:id)
    f_ids << id
  end
end
