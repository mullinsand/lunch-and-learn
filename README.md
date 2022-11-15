# Lunch and Learn

## Table of contents

- [Schema](#schema)
- [Setup](#setup)
- [APIs_Used](#apis-used)
- [Endpoints](#endpoints)
- [Contributors](#contributors)


___

## Setup

- `Ruby 2.7.4`
- `Rails 5.2.8.1'`
- [Fork this repository](https://github.com/mullinsand/lunch-and-learn)
- Clone your fork
- From the command line, install gems and set up your DB:
- `bundle install`
- `rails db:{create,migrate,seed}`
- run the server with 'rails s'
- Go to Postman and use one of these endpoints. The endpoints must look something like: http://localhost:3000/api/v1/recipes
<!-- - Alternatively you can download the Postman Suite and run the [premade endpoints](./app/assets/files/lunch-and-learn.postman_collection.json) -->

___

## APIs Used

- [Edamam](https://restcountries.com/#api-endpoints-v3-all)
- [REST Countries](https://developer.edamam.com/edamam-recipe-api)
- [YouTube](https://developers.google.com/youtube/v3/docs/search/list)
- [Places](https://apidocs.geoapify.com/docs/places/#categories)
- [Unsplash](https://unsplash.com/documentation)

___

## Schema: 

<img src="./app/assets/images/schema.png" alt="The schema of the project includes a table for Users and Favorites." />

___

## Endpoints

### GET /api/v1/recipes
- Provides a list of up to 10 recipes from a country
- Each recipe contains:
    - recipe name (title)
    - url link to the recipe (url)
    - country used for the search (country)
    - an image's url from the recipe (image)
- Set country using query params (eg. /api/v1/recipes?country=thailand)
- If no country is selected, a random country is chosen
- Standard response looks like:
```
{
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Sriracha",
                "url": "http://www.jamieoliver.com/recipes/vegetables-recipes/sriracha/",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com/."
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```
- No results response
```
{
  "data": []
}
```

___

### GET /api/v1/learning_resources
- Provides learning resources for a specific country
- Learning resources includes:
    - Short video from Mr. History YouTube channel (with video title and YouTube id)
    - 10 images pertaining to the specified country (each with an alt tag and url)
- If no images or video are available for that country, these attributes will be empty (`[]`)
- Set country using query params (eg. /api/v1/learning_resources?country=thailand)
- If no country is selected, a random country is chosen
- Standard response looks like:
```
{
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "laos",
            "video": {
                "title": "A Super Quick History of Laos",
                "youtube_video_id": "uw8hjVqxMXw"
            },
            "images": [
                {
                    "alt_tag": "standing statue and temples landmark during daytime",
                    "url": "https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "five brown wooden boats",
                    "url": "https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwyfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "orange temples during daytime",
                    "url": "https://images.unsplash.com/photo-1563492065599-3520f775eeed?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwzfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {...},
                {...},
                {...},
                {etc},
              ]
        }
    }
}
```

___

### POST /api/v1/users
- User information requested through the body as a JSON payload
- Unique API key will be generated and included in response
- Email addresses must be unique for successful POST
- Request format:
```
Content-Type: application/json
Accept: application/json

{
  "name": "Athena Dao",
  "email": "athenadao@bestgirlever.com",
  "password": "123456",
  "password_confirmation": "123456"
}
```

- Successful response format:
```
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "name": "Athena Dao",
      "email": "athenadao@bestgirlever.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

___

### POST /api/v1/favorites
- Add a recipe to a user's favorite recipes list
- Stores the country, recipe link, and recipe title as a favorite
- Request format:
```
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
    "api_key": "jgn983hy48thw9begh98h4539h4",
    "country": "thailand",
    "recipe_link": "https://www.tastingtable.com/.....",
    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
}
```
- Successful response format:
```
{
    "success": "Favorite added successfully"
}
```

___

### GET /api/v1/favorites
- Get a list of all a user's favorites
- Request format:
```
Content-Type: application/json
Accept: application/json

{
    "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
- Response format:
```
{
    "data": [
        {
            "id": "1",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Recipe: Egyptian Tomato Soup",
                "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                "country": "egypt",
                "created_at": "2022-11-02T02:17:54.111Z"
            }
        },
        {
            "id": "2",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
                "recipe_link": "https://www.tastingtable.com/.....",
                "country": "thailand",
                "created_at": "2022-11-07T03:44:08.917Z"
            }
        }
    ]
 }
```
- Response will be an empty array if user has no favorites

___

### DELETE /api/v1/favorites

- Removes a favorite from a user's favorites list
- Request format:
```
Content-Type: application/json
Accept: application/json

{
    "api_key": "jgn983hy48thw9begh98h4539h4",
    "favorite_id": "14"
}
```
