require 'stripe_mock'

RSpec.describe 'User can buy subscritption' do
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'with valid stripe token' do
    describe "successfully" do
      describe 'in english' do
        before do
          post '/api/v1/subscriptions',
          params: {
            stripeToken: stripe_helper.generate_card_token    
          },
          headers: headers
          user.reload
        end
  
        it 'with valid stripe token recieve successful response' do
          expect(response).to have_http_status 200
        end
  
        it 'receives success message' do
          expect(response_json["message"]).to eq 'Transaction cleared'
        end
  
        it 'has their role updated to subscriber' do
          expect(user.role).to eq 'subscriber'
        end
      end

      describe 'in swedish' do
        before do
          post '/api/v1/subscriptions',
          params: {
            stripeToken: stripe_helper.generate_card_token,
            locale: :sv    
          },
          headers: headers
          user.reload
        end

        it 'receives success message in swedish' do
          expect(response_json["message"]).to eq 'Betalning genomförd'
        end

      end
    end
  end

  describe "unsuccessfully" do
    describe 'with invalid stripe token' do
      before do
        post '/api/v1/subscriptions',
        params: {
          stripeToken: 123456789    
        },
        headers: headers
      end

      it "recieves message 'Transaction rejected, token invalid'" do
        expect(response_json["message"]).to eq 'Transaction rejected, token invalid'
      end

      it 'has their role remain at user status' do
        expect(user.role).to eq 'user'
      end
    end

    describe 'with no stripe token' do
      before do
        post '/api/v1/subscriptions',
        headers: headers
      end

      it "recieves 'No Stripe token detected'" do
        expect(response_json["message"]).to eq 'No Stripe token detected'
      end
    end

    describe 'when user is not signed in' do
      before do
        post '/api/v1/subscriptions',
          params: {
            stripeToken: stripe_helper.generate_card_token    
          }
      end

      it 'returns unsuccessful response' do
        expect(response).to have_http_status 401
      end

      it 'returns message to sign in or register first' do
        expect(response_json["errors"][0]).to eq 'You need to sign in or sign up before continuing.'
      end
    end
  end
end 