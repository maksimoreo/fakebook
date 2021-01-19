RSpec.shared_context 'post and user context' do
  let(:user) { User.create(username: 'hello', email: 'hello@hi.com', password: 123123, password_confirmation: 123123) }
  let(:post) { user.posts.create(text: 'post text. hello!') }
end
