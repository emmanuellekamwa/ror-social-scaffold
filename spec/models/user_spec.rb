require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures name of user is present' do
      user = User.new(email: 'user@gmail.com', password: 'password').save
      expect(user).to eql(false)
    end

    it 'ensures max length for name to be 20' do
      user = User.new(name: 'Kamwa Emmanuelle Alix', email: 'user@gmail.com', password: 'password').save
      expect(user).to eql(false)
    end

    it 'should save successfully' do
      user = User.new(name: 'User1', email: 'user@gmail.com', password: 'password').save
      expect(user) == true
    end
  end

  context 'ActiveRecord associations' do
    it 'belongs to user' do
      user = Friendship.reflect_on_association(:user)
      expect(user.macro).to eq(:belongs_to)
    end

    it 'belongs to friend' do
      user = Friendship.reflect_on_association(:friend)
      expect(user.macro).to eq(:belongs_to)
    end
  end

  context 'Attributes Validation' do
    friendship = Friendship.new(user_id: @user_one, friend_id: nil, status: 'pending')

    it 'should invalidate the user_id of value nil' do
      expect(friendship).to_not be_valid
    end
  end
end
