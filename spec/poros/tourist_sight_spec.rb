require 'rails_helper'

RSpec.describe TouristSight do
  before :each do
    distance = 20000
    capital_info = {
      lat: 52.52,
      long: 13.4
    }
    VCR.use_cassette('germany_country_lookup') do
      VCR.use_cassette('germany_places_tourist') do
        @tourist_sights_list = PlacesService.capital_tourist_sights(capital_info, distance)
      end
    end
    @tourist_sight_info = @tourist_sights_list[:features].first
    @tourist_sight = TouristSight.new(@tourist_sight_info)
  end
  describe 'initialization' do
    it 'instantiates as a tourist sight object' do
      expect(@tourist_sight).to be_a(TouristSight)
    end

    it 'has attributes' do
      expect(@tourist_sight.name).to eq(@tourist_sight_info[:properties][:name])
      expect(@tourist_sight.address).to eq(@tourist_sight_info[:properties][:formatted])
      expect(@tourist_sight.place_id).to eq(@tourist_sight_info[:properties][:place_id])
    end
  end
end