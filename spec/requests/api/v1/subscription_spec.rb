require 'stripe_mock'

RSpec.describe 'USer can buy subscritption' do
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  let(:successful_token) { post '/api/v1/subscriptions', params: {  stripeEmail: user.email,
    stripeToken: stripe_helper.generate_card_token    
    }, headers: headers
      user.reload }

  describe "User pays for subscritption" do
    before do
      successful_token
    end

    it 'Successfully and becomes subscriber' do
      expect(response).to have_http_status 200
    end

  end
end 