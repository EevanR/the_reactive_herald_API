RSpec.describe 'GET /api/v1/articles/:id', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let!(:article) { create(:article,
                          title: 'Breaking News',
                          body: 'Some breaking but also long content.' *  10 )}
  let!(:subscriber) { create(:subscriber) }
  let(:subscriber_credentials) { subscriber.create_new_auth_token }
  let!(:subscriber_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(subscriber_credentials) }

  describe 'Successfully' do
    before do
      get "/api/v1/articles/#{article.id}", headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns article title' do
      expect(response_json["article"]["title"]).to eq "Breaking News"
    end
  end

  describe 'With invalid :id' do
    before do
      get "/api/v1/articles/10000", headers: headers
    end

    it 'returns error if article does not exist' do
      expect(response_json["error"]).to eq "Article not found"
    end
  end
  
  describe 'Successfully' do
    before do
      get "/api/v1/articles/#{article.id}", 
      params: {
        "article[published]": true
      },
      headers: subscriber_headers
  end

    it 'returns article title' do
      expect(response_json["article"]["body"].length).to eq 75
    end
  end
  
end