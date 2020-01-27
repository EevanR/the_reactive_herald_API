RSpec.describe 'GET /api/v1/articles/:id', type: :request do
  let(:subscriber)  { create(:subscriber)}
  let(:subscriber_credentials) { subscriber.create_new_auth_token }
  let!(:subscriber_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(subscriber_credentials) }
  let!(:article) { create(:article,
                          title: 'Breaking News',
                          body: 'Some breaking but also long content.' *  10 )}
  let(:serialization) { Articles::ShowSerializer.new(article) }

  describe 'Successfully' do
    before do
      get "/api/v1/articles/#{article.id}", 
      params: {
        "role": "subscriber"
      },
      headers: subscriber_headers
    end

    it 'returns article title' do
      expect(response_json["article"]["body"].length).to eq 225
    end

  end
end
