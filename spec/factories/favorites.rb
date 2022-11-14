FactoryBot.define do
  factory :favorite do
    user { nil }
    country { "MyString" }
    recipe_link { "MyString" }
    recipe_title { "MyString" }
  end
end
