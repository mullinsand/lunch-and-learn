require 'rails_helper'

RSpec.describe LearningResourceFacade do
  describe 'class methods' do
    describe 'resouces about country' do
      before :each do
        @country = 'germany'
        VCR.use_cassette('germany_unsplash_image_search') do
          VCR.use_cassette('germany_youtube_video_search') do
            @learning_recource = LearningResourceFacade.generate_for(@country)
          end
        end
      end
      
      it 'returns a learning resource class object' do
        expect(@learning_recource).to be_a(LearningResource)
        expect(@learning_recource.country).to eq(@country)
        expect(@learning_recource.video).to be_a(CountryVideo)
        expect(@learning_recource.images).to be_an(Array)
        expect(@learning_recource.images.length).to eq(10)
        expect(@learning_recource.images.first).to be_a(CountryImage)
      end

      context 'no search results' do
        it 'returns an empty array if no video or images are found' do
          @country = 'hjkladfhjkadfjklgadklfjgkohuhadsfgo;uihaweriouh'
          VCR.use_cassette('no_results_LR_image_search') do
            VCR.use_cassette('no_results_LR_video_search') do
              @learning_recource = LearningResourceFacade.generate_for(@country)
            end
          end
          expect(@learning_recource.video).to eq([])
          expect(@learning_recource.images).to eq([])
        end
      end
    end
  end
end