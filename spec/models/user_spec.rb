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

  context 'helper methods test' do
    before(:each) do
      @user1 = User.create(name: 'User1', email: 'user1@gmail.com', password: 'password')
      @user2 = User.create(name: 'User2', email: 'user2@gmail.com', password: 'password')
    end

    it 'should reject the incoming friend request' do
      @user1.friend_requests.new(friend_id:@user2.id, status: false).save
      @user2.confirm_friend(user1)
      expect(@user1.friend_requests.size).to eq(0)
    end

    it 'should confirm the incoming friend request' do
      @user1.friend_requests.new(friend_id:@user2.id, status: false).save
      @user2.confirm_friend(@user1)
      expect(@user1.friend_requests.first.status).to.eq(true)
    end

    it 'should return one pending friend request' do
      @user1.friend_requests.new(friend_id:@user2.id, status: false).save
      expect(@user1.pending_friends.length).to eq(1)
    end
  end
end