$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "favourite_object/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "favourite_object"
  s.version     = FavouriteObject::VERSION
  s.authors     = ["William Porter"]
  s.email       = ["wp@papercloud.com.au"]
  s.homepage    = "http://papercloud.com.au"
  s.summary     = "Favourites plugin"
  s.description = "A dropin utility that adds favourites functionality to any object"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.0", "<= 5.0"
  s.add_dependency "kaminari"
  s.add_dependency "active_model_serializers"


  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "awesome_print"
  s.add_development_dependency "json_spec"

  s.test_files = Dir["spec/**/*"]

end
