require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'two users context' do
    let(:users) do
      Array.new(2) do |i|
        User.create(username: "user#{i}", email: "user#{i}@hi.com", password: 123123, password_confirmation: 123123)
      end
    end

    describe 'save' do
      context "when two users aren't friends" do
        it "creates friendship model when two users aren't friends" do
          f = Friendship.new(from_user: users[0], to_user: users[1])
          expect(f.save).to eql(true)
        end
      end

      context 'a request was already sent by sender' do
        it "doesn't save friendship model when the request wasn't accepted" do
          Friendship.create(from_user: users[0], to_user: users[1])
          another_request = Friendship.new(from_user: users[0], to_user: users[1])
          expect(another_request.save).to eql(false)
        end

        it "doesn't save friendship model when the request was accepted" do
          request = Friendship.create(from_user: users[0], to_user: users[1])
          request.accept_request
          another_request = Friendship.new(from_user: users[0], to_user: users[1])
          expect(another_request.save).to eql(false)
        end
      end

      context 'a request was already sent by receiver' do
        it "doesn't save friendship model when the request wasn't accepted" do
          Friendship.create(from_user: users[1], to_user: users[0])
          another_request = Friendship.new(from_user: users[0], to_user: users[1])
          expect(another_request.save).to eql(false)
        end

        it "doesn't save friendship model when the request was accepted" do
          request = Friendship.create(from_user: users[1], to_user: users[0])
          request.accept_request
          another_request = Friendship.new(from_user: users[0], to_user: users[1])
          expect(another_request.save).to eql(false)
        end
      end
    end

    describe 'accept_request' do
      context 'user1 sends friendship request to user2' do
        let(:friendship) { Friendship.create(from_user: users[1], to_user: users[0]) }

        context "when two users aren't friends" do
          it "accepts the request and returns true" do
            expect(friendship.accept_request).to eql(true)
            expect(friendship.accepted?).to eql(true)
            expect(friendship.valid?).to eql(true)
          end
        end

        context "when two users are friends" do
          it "doesn't update the model and returns false" do
            friendship.accept_request
            expect(friendship.accept_request).to eql(false)
            expect(friendship.accepted?).to eql(true)
            expect(friendship.valid?).to eql(true)
          end
        end
      end
    end
  end
end
