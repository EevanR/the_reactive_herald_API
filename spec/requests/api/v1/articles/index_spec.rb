RSpec.describe 'GET /api/v1/articles', type: :request do
  let(:journalist) { create(:journalist)}
  let!(:journalist_headers) { { HTTP_ACCEPT: 'application/json' } }
  let!(:article) do
    10.times do
      create(:article, journalist_id: journalist.id)
    end
  end

  describe 'Get first page' do
    before do
      get '/api/v1/articles'
    end

    it 'return a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns 4 articles' do
      expect(response_json['articles'].count).to eq 4
    end

    it 'returns only first 75 characters of each article' do
      expect(response_json['articles'][0]['body'].length).to eq 75
    end

    it 'returns metadata for current page' do
      expect(response_json["meta"]["current_page"]).to eq 1
    end  
  end

  describe 'Get second page' do
    before do
      get '/api/v1/articles', params: { page: 2 }
    end

    it 'return a 200 response status' do
      expect(response).to have_http_status 200
    end
    
    it 'returns page 2' do
      expect(response_json["meta"]["current_page"]).to eq 2
    end

    it 'returns page 1 for previous page' do
      expect(response_json["meta"]["prev_page"]).to eq 1
    end

    it 'returns page 3 for previous page' do
      expect(response_json["meta"]["next_page"]).to eq 3
    end

    it 'returns total number of entries' do
      expect(response_json["meta"]["total_count"]).to eq 10
    end
  end

end