require 'rails_helper'

require_relative '../post_and_user_context'

RSpec.describe Like, type: :model do
  include_context 'post and user context'

  it "doesn't allow to like one post twice" do
    like1 = post.likes.create(user: user)
    like2 = post.likes.create(user: user)
    expect(like1.new_record?).to eql(false)
    expect(like2.new_record?).to eql(true)
  end
end
