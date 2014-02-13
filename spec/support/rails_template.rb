generate :model, 'user email:string'
generate :model, 'arbitrary_object content:string'


generate "favourite_object:install"

generate "favourite_object:template ArbitraryObject"

# Finalise
rake "db:migrate"
rake "db:test:prepare"