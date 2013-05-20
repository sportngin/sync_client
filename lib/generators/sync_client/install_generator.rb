module SyncClient
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates a SyncClient initializer and copy other files to your application."
      # class_option :bleh

      def copy_initializer
        template "sync_client.rb", "config/initializers/sync_client.rb"
      end
    end
  end
end
