module PubSubClient
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates a PubSubClient initializer and copy other files to your application."
      # class_option :bleh

      def copy_initializer
        template "pub_sub_client.rb", "config/initializers/pub_sub_client.rb"
      end
    end
  end
end
