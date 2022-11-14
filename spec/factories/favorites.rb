FactoryBot.define do
  factory :favorite do
    country { Faker::Lorem.word }
    recipe_link { Faker::Lorem.sentence }
    recipe_title { Faker::Lorem.sentence }
    user
  end
end
