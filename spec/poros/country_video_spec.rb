require 'rails_helper'

RSpec.describe CountryVideo do
  before :each do
    @video_data = { :kind=>"youtube#searchResult",
                    :etag=>"lmwiXeibmOitA4n8oUrK3sZvbyQ",
                    :id=>{:kind=>"youtube#video", :videoId=>"7sxora2imC0"},
                    :snippet=>
                      {:publishedAt=>"2020-08-29T12:59:40Z",
                       :channelId=>"UCluQ5yInbeAkkeCndNnUhpw",
                        :title=>"A Super Quick History of Germany",
                        :description=>"Sources: A Concise History of Germany (2019) by Mary Fulbrook, Cambridge University Press, Cambridge, UK. The Shortest ...",
                        :thumbnails=>
                        {:default=>{:url=>"https://i.ytimg.com/vi/7sxora2imC0/default.jpg", :width=>120, :height=>90},
                          :medium=>{:url=>"https://i.ytimg.com/vi/7sxora2imC0/mqdefault.jpg", :width=>320, :height=>180},
                          :high=>{:url=>"https://i.ytimg.com/vi/7sxora2imC0/hqdefault.jpg", :width=>480, :height=>360}},
                        :channelTitle=>"Mr History",
                        :liveBroadcastContent=>"none",
                        :publishTime=>"2020-08-29T12:59:40Z"}}
    @video = CountryVideo.new(@video_data)
  end
  describe 'initialization' do
    it 'instantiates as a recipe object' do
      expect(@video).to be_a(CountryVideo)
    end

    it 'has attributes' do
      expect(@video.video_id).to eq(@video_data[:id][:videoId])
      expect(@video.title).to eq(@video_data[:snippet][:title])
    end
  end
end