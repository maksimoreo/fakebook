require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'save' do
    it "doesn't save without username" do
      user = User.new(email: 'hello@hi.com', password: 123123, password_confirmation: 123123)
      expect(user.save).to eql(false)
    end

    it 'save when all conditions are met' do
      user = User.new(username: 'hello', email: 'hello@hi.com', password: 123123, password_confirmation: 123123)
      expect(user.save).to eql(true)
    end

    context 'with saved user' do
      let(:user) { User.create(username: 'hello', email: 'hello@hi.com', password: 123123, password_confirmation: 123123) }

      it "doesn't save new user with same username" do
        expect(user.new_record?).to eql(false) # 'user' won't be created if not mention it in the test (lazy evaluation)

        new_user = User.new(username: 'hello', email: 'minecraft@hi.com', password: 123123, password_confirmation: 123123)
        expect(new_user.save).to eql(false)
      end

      it "doesn't save new user with same email" do
        expect(user.new_record?).to eql(false)

        new_user = User.new(username: 'minecraft', email: 'hello@hi.com', password: 123123, password_confirmation: 123123)
        expect(new_user.save).to eql(false)
      end
    end
  end

  describe 'send_friendship_request' do
    it 'sends a friendship request to other user' do
      user1 = User.create(username: 'user1', email: 'user1@hi.com', password: 123123, password_confirmation: 123123)
      user2 = User.create(username: 'user2', email: 'user2@hi.com', password: 123123, password_confirmation: 123123)
      friendship_request = user1.send_friendship_request(user2)
      expect(user1.sent_friendship_requests.include?(friendship_request)).to eql(true)
      expect(user2.incoming_friendship_requests.include?(friendship_request)).to eql(true)
    end
  end
end
