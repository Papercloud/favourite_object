generate :model, 'user email:string'

# generate "favourite:install"

# Finalise
rake "db:migrate"
rake "db:test:prepare"