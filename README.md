favourite_object
================
A dropin utility that adds favourites functionality to any rails application. But simpling include a partial you can add a favourite button to any object.


Install:
```
gem 'favourite_object'
rails g favourite_object:install
rake db:migrate
```
Mount inside your `routes.rb` with your custom namespace eg. `/api` will result in `/api/favourite_object` routes
```ruby
Application.routes.draw do
	mount FavouriteObject::Engine, at: '/api'
end
```

For every object you want to be favouritable
- Generates a favourite_object/ObjectName/message.html.erb file which is used to display the description of an object
```
rails g favourite_object:template ObjectName
```

Favourite button(pass the object to be favourited and the user object)
```
<%= render :partial => 'favourite_object/favourites/favourite_icon',
	:locals => {:object => object}%>
```

###Api Documentation:
Route: `GET: /favourite_object/favourites/:target_type/:target_id.json`

Example response:
```json
{
    "favourite" => {
                      "id" => 1,
               "target_id" => 1,
             "target_type" => "ClassName",
           "is_favourited" => true,
        "third_party_flag" => false,
    }
}
```

Route: `GET: /favourite_object/favourites.json`

Optional params: `{target_type: Class, target_ids: [1, 5, 10], serializer: 'lite'}`

- *Note*: `serializer: 'lite'` returns a skinny serializer which doesn't include a description and params

Example response:
```json
{
    "favourites" => [
        {
                          "id" => 1,
                   "target_id" => 1,
                 "target_type" => "Class",
               "is_favourited" => true,
	         "description" => "Mr. Blobby",
	    "third_party_flag" => false,
	                "data" => []
        }
    ]
}
```

Route: `PUT: /favourite_object/favourites/:target_type/:target_id.json`

Params: `{favourite: {is_favourited: true | false}}`

Example response:
```json
{
    "favourite" => {
                      "id" => 1,
               "target_id" => 1,
             "target_type" => "ClassName",
           "is_favourited" => true,
        "third_party_flag" => false,
    }
}
```
