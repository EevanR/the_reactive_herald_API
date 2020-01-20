RSpec.describe 'POST /api/admin/articles', type: :request do
  let(:editor)  { create(:editor)}
  let(:editor_credentials) { editor.create_new_auth_token }
  let!(:editor_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(editor_credentials) }

  describe 'Successfully publishes article' do
    before do
      post "/api/admin/articles/1",
      params: {
        article: {
          published: true
        }
      },
      headers: editor_headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'unsuccessfully with' do
    describe 'non logged in user' do
      let!(:non_authorized_headers) { { HTTP_ACCEPT: 'application/json' } }
      before do
        post "/api/admin/articles/1",
        params: {
          article: {
            published: true
          }
        },
        headers: non_authorized_headers
      end
      
      it 'returns a 401 response status' do
        expect(response).to have_http_status 401
      end

      it 'returns error message' do
        expect(response_json["errors"][0]).to eq "You need to sign in or sign up before continuing."
      end
    end

    describe 'user that is not an editor' do
      let(:journalist) { create(:user, role: 'journalist')}
      let(:journalist_credentials) { journalist.create_new_auth_token }
      let!(:journalist_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(journalist_credentials) }
    
      before do
        post "/api/admin/articles/1",
        params: {
          article: {
            published: true
          }
        },
        headers: journalist_headers
      end
  
      it 'returns a 404 response status' do
        expect(response).to have_http_status 404
      end

      it 'returns error message' do
        expect(response_json["error"]).to eq "Not authorized!"
      end
    end

  end
end