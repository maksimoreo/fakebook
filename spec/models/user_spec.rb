require 'rails_helper'

RSpec.describe User, type: :model do
  it 'not valid without username' do
    user = User.new(email: 'hello@hi.com', password: 123123, password_confirmation: 123123)
    expect(user.valid?).to eql(false)
  end

  it 'valid when all conditions are met' do
    user = User.new(username: 'hello', email: 'hello@hi.com', password: 123123, password_confirmation: 123123)
    expect(user.save).to eql(true)
  end
end
