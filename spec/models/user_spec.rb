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
end
