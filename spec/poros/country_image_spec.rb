require 'rails_helper'

RSpec.describe CountryImage do
  before :each do
    @image_data = {
                    "id": "gsllxmVO4HQ",
                    "created_at": "2018-06-05T06:50:34Z",
                    "updated_at": "2022-11-12T22:03:35Z",
                    "promoted_at": nil,
                    "width": 5034,
                    "height": 3356,
                    "color": "#d9d9d9",
                    "blur_hash": "L.IrQxRlnhM}yZWFoeS5R+bcogoy",
                    "description": "Traveling on motorbike in norther thailand we came across these amazing sculptural temples and buildings.",
                    "alt_description": "standing statue and temples landmark during daytime",
                    "urls": {
                        "raw": "https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzk3NzN8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyOTA2OTA&ixlib=rb-4.0.3",
                        "full": "https://images.unsplash.com/photo-1528181304800-259b08848526?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzNzk3NzN8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyOTA2OTA&ixlib=rb-4.0.3&q=80",
                        "regular": "https://images.unsplash.com/photo-1528181304800-259b08848526?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNzk3NzN8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyOTA2OTA&ixlib=rb-4.0.3&q=80&w=1080",
                        "small": "https://images.unsplash.com/photo-1528181304800-259b08848526?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNzk3NzN8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyOTA2OTA&ixlib=rb-4.0.3&q=80&w=400",
                        "thumb": "https://images.unsplash.com/photo-1528181304800-259b08848526?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNzk3NzN8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyOTA2OTA&ixlib=rb-4.0.3&q=80&w=200",
                        "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1528181304800-259b08848526"
                    },
                    "links": {
                        "self": "https://api.unsplash.com/photos/gsllxmVO4HQ",
                        "html": "https://unsplash.com/photos/gsllxmVO4HQ",
                        "download": "https://unsplash.com/photos/gsllxmVO4HQ/download?ixid=MnwzNzk3NzN8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyOTA2OTA",
                        "download_location": "https://api.unsplash.com/photos/gsllxmVO4HQ/download?ixid=MnwzNzk3NzN8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyOTA2OTA"
                    },
                    "likes": 256,
                    "liked_by_user": false,
                    "current_user_collections": [],
                    "sponsorship": nil,
                    "topic_submissions": {
                        "nature": {
                            "status": "rejected"
                        },
                        "architecture-interior": {
                            "status": "rejected"
                        },
                        "spirituality": {
                            "status": "rejected"
                        },
                        "arts-culture": {
                            "status": "rejected"
                        }
                    },
                    "user": {
                        "id": "hae8rLbohfw",
                        "updated_at": "2022-11-09T13:24:37Z",
                        "username": "cadop",
                        "name": "Mathew Schwartz",
                        "first_name": "Mathew",
                        "last_name": "Schwartz",
                        "twitter_username": nil,
                        "portfolio_url": "http://smart-art.org",
                        "bio": "Researcher and designer that likes photography and open source work.  Happy to share my photos and hope people find good use from them.",
                        "location": nil,
                        "links": {
                            "self": "https://api.unsplash.com/users/cadop",
                            "html": "https://unsplash.com/@cadop",
                            "photos": "https://api.unsplash.com/users/cadop/photos",
                            "likes": "https://api.unsplash.com/users/cadop/likes",
                            "portfolio": "https://api.unsplash.com/users/cadop/portfolio",
                            "following": "https://api.unsplash.com/users/cadop/following",
                            "followers": "https://api.unsplash.com/users/cadop/followers"
                        },
                        "profile_image": {
                            "small": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
                            "medium": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
                            "large": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
                        },
                        "instagram_username": nil,
                        "total_collections": 11,
                        "total_likes": 0,
                        "total_photos": 422,
                        "accepted_tos": true,
                        "for_hire": false,
                        "social": {
                            "instagram_username": nil,
                            "portfolio_url": "http://smart-art.org",
                            "twitter_username": nil,
                            "paypal_email": nil
                        }
                    },
                    "tags": [
                        {
                            "type": "search",
                            "title": "thailand"
                        }
                    ]
                }
    @image = CountryImage.new(@image_data)
  end
  describe 'initialization' do
    it 'instantiates as a recipe object' do
      expect(@image).to be_a(CountryImage)
    end

    it 'has attributes' do
      expect(@image.alt_tag).to eq(@image_data[:alt_description])
      expect(@image.url).to eq(@image_data[:urls][:regular])
    end
  end
end