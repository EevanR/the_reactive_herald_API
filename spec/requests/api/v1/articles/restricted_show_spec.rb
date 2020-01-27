RSpec.describe 'GET /api/v1/articles/:id', type: :request do
  let(:subscriber)  { create(:subscriber)}
  let!(:user) { create(:user) }
  let(:subscriber_credentials) { subscriber.create_new_auth_token }
  let(:user_credentials) { user.create_new_auth_token }
  let!(:subscriber_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(subscriber_credentials) }
  let!(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }
  let!(:article) { create(:article,
                          title: 'Breaking News',
                          body: 'Some breaking but also long content.' *  10 )}
  let(:serialization) { Articles::ShowSerializer.new(article) }

  describe 'Successfully' do

    it 'returns shortened article for user' do
      get "/api/v1/articles/#{article.id}", 
      headers: user_headers
      expect(response_json["article"]["body"].length).to eq 225
    end

    it 'returns full length article for subscriber' do
      get "/api/v1/articles/#{article.id}", 
      headers: subscriber_headers
      expect(response_json["article"]["body"].length).to eq article.body.length
    end
  end
  
end
