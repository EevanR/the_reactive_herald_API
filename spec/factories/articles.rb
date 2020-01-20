FactoryBot.define do
  factory :article do
    title { "Breaking News" }
    body { "Some breaking content"*10}
    association :journalist
  end
end