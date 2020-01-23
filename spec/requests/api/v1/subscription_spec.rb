require 'stripe_mock'

RSpec.describe 'USer can buy subscritption' do
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }
  let(:user) { create(:user) }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe "User would like to pay for subscritption" do
    it 'User pays for subscritption' do
      binding.pry
      customer = Stripe::Customer.create({
        email: 'user@mail.com',
        source: stripe_helper.generate_card_token
      })
      expect(customer.email).to eq('user@mail.com')
    end

    it 'User has insufficent funds' do

    end

    it 'User has expired card' do

    end

    it 'User inputs invalid card number' do

    end

  end
end 