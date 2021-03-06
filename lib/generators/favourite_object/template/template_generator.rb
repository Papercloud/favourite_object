module FavouriteObject
  class TemplateGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)
    argument :addition_classes, :type => :array, :default => []

    def generate_templates
      # generate template files for name
      template "message.html.erb.erb", "app/views/favourite_object/#{name.underscore}/message.html.erb"

      addition_classes.each do |class_name|
        #iterates through each additional class and generates template files
        template "message.html.erb.erb", "app/views/favourite_object/#{class_name.underscore}/message.html.erb"
      end 
    end
  end
end