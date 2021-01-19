RSpec.shared_context 'user context' do
  let(:user) { User.create(username: 'hello', email: 'hello@hi.com', password: 123123, password_confirmation: 123123) }
end
