FactoryBot.define do
  factory :user do
    email { "user#{rand(1...9999)}@mail.com" }
    password { "password" }
    password_confirmation { "password" }
    role {"user"}
    factory :journalist do
      email { "user#{rand(1...9999)}@mail.com" }
      role { "journalist" }
    end
    factory :publisher do
      email { "user#{rand(1...9999)}@mail.com" }
      role { "publisher" }
    end
  end
end