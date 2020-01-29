FactoryBot.define do
  factory :article do
    title { "Breaking News" }
    body { "Some long breaking content"*20}
    association :journalist
  end
end