FactoryBot.define do
  factory :user do
    email { "user#{rand(1...9999)}@mail.com" }
    password { "password" }
    password_confirmation { "password" }
    role {"user"}
    factory :journalist do
      role { "journalist" }
    end
    factory :publisher do
      role { "publisher" }
    end
    factory :subscriber do
      role { "subscriber" }
    end
  end
end