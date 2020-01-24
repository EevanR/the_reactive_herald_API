require 'stripe_mock'

RSpec.describe 'USer can buy subscritption' do
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  let(:successful_token) { post '/api/v1/subscriptions', 
    params: {
    stripeToken: stripe_helper.generate_card_token    
    }, headers: headers
  user.reload }

  let(:invalid_token) { post '/api/v1/subscriptions', 
    params: {
    stripeToken: 123456789
    }, headers: headers}

  describe "User pays for subscription" do
    before do
      successful_token
    end

    it 'Successfully' do
      expect(response).to have_http_status 200
    end

    it 'has their role updated to subscriber' do
      binding.pry
      expect(user.role).to eq 'subscriber'
    end
  end

  describe "User pays for subscription with invalid token" do
    before do
      invalid_token
    end

    it 'unsuccessfully' do
      expect(response_json["error"]).to eq 'Transaction rejected, token invalid'
    end

    it 'has their role remain at user status' do
      expect(user.role).to eq 'user'
    end
  end
end 