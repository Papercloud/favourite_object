$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "favourite/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "favourite"
  s.version     = Favourite::VERSION
  s.authors     = ["William Porter"]
  s.email       = ["wp@papercloud.com.au"]
  s.homepage    = "http://papercloud.com.au"
  s.summary     = "Favourites plugin"
  s.description = "A dropin utility that adds favourites functionality to any object"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "awesome_print"

  s.test_files = Dir["spec/**/*"]

end
