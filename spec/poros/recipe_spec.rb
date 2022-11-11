require 'rails_helper'

RSpec.describe Recipe do
  before :each do
    @recipe_data = { url: Faker::Internet.url,
                    label: Faker::Lorem.sentence,
                    image: Faker::LoremFlickr.image
                  }
    @country = 'Thailand'
    @recipe = Recipe.new(@recipe_data, @country)
  end
  describe 'initialization' do
    it 'instantiates as a recipe object' do
      expect(@recipe).to be_a(Recipe)
    end

    it 'has attributes' do
      expect(@recipe.title).to eq(@recipe_data[:label])
      expect(@recipe.url).to eq(@recipe_data[:url])
      expect(@recipe.image).to eq(@recipe_data[:image])
      expect(@recipe.country).to eq(@country)
    end
  end
end