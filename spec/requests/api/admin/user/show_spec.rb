RSpec.describe 'GET/api/admin/users', type: :request do
  let(:subscriber)  { create(:subscriber)}
  let(:subscriber_credentials) { subscriber.create_new_auth_token }
  let!(:subscriber_headers) {{ HTTP_ACCEPT: 'application/json' }}

  describe 'Succesfully show profile page' do
    before do
      get "/api/admin/users/#{subscriber.id}", headers: subscriber_headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns user email' do
      expect(response_json["user"]["email"]).to eq (subscriber.email)
    end

    it 'returns user role as subscriber' do
      expect(response_json["user"]["role"]).to eq "subscriber"
    end
  end

  describe 'Unsuccesfully show profile page' do
    let(:user)  { create(:user)}
    let(:user_credentials) { user.create_new_auth_token }
    let!(:user_headers) {{ HTTP_ACCEPT: 'application/json' }}
    before do
      get "/api/admin/users/#{user.id}", headers: subscriber_headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end
end
