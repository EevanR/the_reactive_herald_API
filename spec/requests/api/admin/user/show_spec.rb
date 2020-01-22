RSpec.describe 'GET/api/admin/users', type: :request do
  let(:user)  { create(:user)}
  let(:user_credentials) { user.create_new_auth_token }
  let!(:user_headers) {{ HTTP_ACCEPT: 'application/json' }}

  describe 'Succesfully show profile page' do
    before do
      get "/api/admin/users/#{user.id}"
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end
end
