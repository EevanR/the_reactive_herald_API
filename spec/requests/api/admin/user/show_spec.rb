RSpec.describe 'GET/api/admin/users', type: :request do
  let(:user)  { create(:user)}
  let(:user_credentials) { user.create_new_auth_token }
  let!(:user_headers) {{ HTTP_ACCEPT: 'application/json' }.merge!(user_credentials)}

  describe 'Succesfully show profile page' do
    before do
      get "/api/admin/users/#{user.id}", headers: user_headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns user email' do
      expect(response_json["user"]["email"]).to eq (user.email)
    end
  end

  describe 'Cant see profile page unless authorized' do
    let!(:non_authorized_headers) { { HTTP_ACCEPT: 'application/json' } }
    before do
      get "/api/admin/users/#{user.id}", headers: non_authorized_headers
    end

    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end
  end
end
