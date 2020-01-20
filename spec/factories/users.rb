FactoryBot.define do
  factory :user do
    email { "user@mail.com" }
    password { "password" }
    password_confirmation { "password" }
    role {"user"}
    factory :journalist do
      email { "user2@mail.com" }
      role { "journalist" }
    end
  end
    
end