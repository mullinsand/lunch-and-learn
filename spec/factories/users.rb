FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password }
    api_key { SecureRandom.uuid }
  end
end