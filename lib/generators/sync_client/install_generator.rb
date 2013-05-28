require 'rails/generators'
module SyncClient
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates a SyncClient initializer and copy other files to your application."
      # class_option :bleh

      def copy_initializer
        template "sync_client.rb", "config/initializers/sync_client.rb"
      end

      def create_executable_file
        if ActiveSupport::VERSION::MAJOR >= 4
          prefix = 'bin'
        else
          prefix = 'script'
        end
        template "script", "#{prefix}/sync_client"
        chmod "#{prefix}/sync_client", 0755
      end
    end
  end
end
