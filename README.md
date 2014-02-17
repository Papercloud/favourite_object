favourite_object
================
A dropin utility that adds favourites functionality to any rails application. But simpling include a partial you can add a favourite button to any object.


Install: 
```
gem 'favourite_object'
rails g favourite_object:install
rake db:migrate
```

For every object you want to be favouritable
- Generates a favourite_object/#{name.underscore}/message.html.erb file which is used to display the description of an object
```
rails g favourite_object:template ObjectName
```


Favourite button(pass the object to be favourited and the user object)
```
<%= render :partial => 'favourite_object/favourites/favourite_icon', 
	:locals => {:object => object, :owner => @user}%>
```