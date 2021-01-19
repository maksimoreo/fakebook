require 'rails_helper'

require_relative '../post_and_user_context'

RSpec.describe Comment, type: :model do
  include_context 'post and user context'

  context 'without post' do
    it "does't save" do
      comment = user.comments.new(text: 'hi')
      expect(comment.save).to eql(false)
    end
  end

  context 'without user' do
    it "does't save" do
      comment = post.comments.new(text: 'hi')
      expect(comment.save).to eql(false)
    end
  end

  context 'saved post' do
    it "does save" do
      comment = post.comments.new(user: user, text: 'hi')
      expect(comment.save).to eql(true)
    end
  end
end
