require 'rails_helper'

RSpec.describe LearningResource do
  before :each do
    @country = 'germany'
    VCR.use_cassette('germany_unsplash_image_search') do
      VCR.use_cassette('germany_youtube_video_search') do
        @video = YoutubeFacade.video_about(@country)
        @pictures = UnsplashFacade.images_of(@country)
      end
    end
    @learning_recource = LearningResource.new(@country, @video, @pictures)
  end
  describe 'initialization' do
    it 'instantiates as a recipe object' do
      expect(@learning_recource).to be_a(LearningResource)
    end

    it 'has attributes' do
      expect(@learning_recource.country).to eq(@country)
      expect(@learning_recource.video).to eq(@video)
      expect(@learning_recource.images).to eq(@pictures)
    end
  end
end