RSpec.describe Articles::ShowSerializer, type: :serializer do
  let!(:article) { create(:article,
                          title: 'Breaking News',
                          body: 'Some breaking content') }
  let(:serialization) { Articles::ShowSerializer.new(article) }
  subject { JSON.parse(serialization.to_json) }

  it 'contains id, title, body and image' do
    expected_keys = ['id', 'title', 'body', 'image']
    expect(subject.keys).to match expected_keys
  end
end