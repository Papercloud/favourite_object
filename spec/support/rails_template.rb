generate :model, 'user email:string'
generate :model, 'arbitrary_object content:string'


generate "favourite_object:install"

# Finalise
rake "db:migrate"
rake "db:test:prepare"