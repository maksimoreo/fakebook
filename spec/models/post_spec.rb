require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post_author) { User.create(username: 'hello', email: 'hello@hi.com', password: 123123, password_confirmation: 123123) }

  it 'is not valid if text is longer than 2k characters' do
    post = Post.new(text: 'a' * 2001, author: post_author)
    expect(post.valid?).to eql(false)
  end

  context 'when all conditions are met' do
    describe 'save' do
      it 'returns true' do
        post = Post.new(text: 'post text', author: post_author)
        expect(post.save).to eql(true)
      end
    end
  end
end
