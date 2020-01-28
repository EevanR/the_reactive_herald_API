FactoryBot.define do
  factory :article do
    
    title { 'Breaking News' }
    body { 'Some breaking content' * 10 }
    association :journalist
    
    after(:create) do |article|
      article.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'ca_basic_logo_320x40.png')),
      filename: 'attachment.png',
      content_type: 'image/png')
    end
  end
end