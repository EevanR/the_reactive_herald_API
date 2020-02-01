# frozen_string_literal: true

RSpec.describe 'GET /api/v1/admin/articles/:id', type: :request do
  let(:publisher)  { create(:publisher)}
  let(:publisher_credentials) { publisher.create_new_auth_token }
  let!(:publisher_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(publisher_credentials) }
  let!(:article) { create(:article)}
  let!(:published_article) {create(:article, published: true, publisher: publisher)}

  describe 'Successfully' do
    describe 'retrieves unpublished article' do
      before do
        get "/api/v1/admin/articles/#{article.id}", headers: publisher_headers
      end

      it 'returns a 200 response status' do
        expect(response).to have_http_status 200
      end

      it 'returns full article body' do
        expect(response_json['article']['body'].length).to eq article.body.length
      end
    end

    describe 'retrieves published article' do
      before do
        get "/api/v1/admin/articles/#{published_article.id}", headers: publisher_headers
      end

      it 'returns full article body' do
        expect(response_json['article']['body'].length).to eq article.body.length
      end
    end
  end

  describe 'With invalid :id' do
    before do
      get '/api/v1/articles/10000', headers: headers
    end

    it 'returns error if article does not exist' do
      expect(response_json['error']).to eq 'Article not found'
    end
  end
end
