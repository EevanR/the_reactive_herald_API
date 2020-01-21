RSpec.describe 'POST /api/admin/articles', type: :request do
  let(:publisher)  { create(:publisher)}
  let(:publisher_credentials) { publisher.create_new_auth_token }
  let!(:publisher_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(publisher_credentials) }
  let!(:unpublished_article) do
    3.times do
      create(:article)
    end
  end
  let!(:published_article) { create(:article) }


  describe 'Successfully lists unpublished articles' do
    before do
      get '/api/admin/articles'
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns 3 articles' do
      expect(response_json['articles'].count).to eq 3
    end
  end

  describe 'unsuccessfully when logged in as a journalist' do
    let(:journalist) { create(:user, role: 'journalist')}
    let(:journalist_credentials) { journalist.create_new_auth_token }
    let!(:journalist_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(journalist_credentials) }
    
    before do
      get '/api/admin/articles'
    end

    it 'returns a 404 response status' do
      expect(response).to have_http_status 404
    end

    it 'returns error message' do
      expect(response_json["error"]).to eq "Not authorized!"
    end
  end
end