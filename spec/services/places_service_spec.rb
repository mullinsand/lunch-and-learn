require 'rails_helper'

RSpec.describe PlacesService do
  describe 'class methods' do
    describe '#capital_tourist_sights' do
      before :each do
        @distance = 20000
        @capital_info = {
          lat: 52.52,
          long: 13.4
        }
        VCR.use_cassette('germany_places_tourist') do
          @tourist_sights_list = PlacesService.capital_tourist_sights(@capital_info, @distance)
        end
      end

      it 'returns a hash of features' do
        expect(@tourist_sights_list).to be_a(Hash)
        expect(@tourist_sights_list[:features]).to be_an(Array)
      end

      it 'each feature element contains a name, formatted address, and place id' do
        tourist_sight = @tourist_sights_list[:features].first
        expect(tourist_sight[:properties][:name]).to be_a(String)
        expect(tourist_sight[:properties][:formatted]).to be_a(String)
        expect(tourist_sight[:properties][:place_id]).to be_a(String)
      end
    end
  end
end