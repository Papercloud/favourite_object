module FavouriteObject
  class Engine < ::Rails::Engine
    isolate_namespace FavouriteObject

  	config.generators do |g|
  	  g.test_framework      :rspec,        :fixture => false
  	  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
  	  g.assets false
  	  g.helper false
  	end

    config.autoload_paths += %W(#{config.root}/lib)
  end
end
