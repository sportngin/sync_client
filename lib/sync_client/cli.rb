require 'thor'
require 'sync_client'
module SyncClient
  class Cli < Thor
    def work
      load_enviroment
      SyncClient::Worker.new().work
    end

    protected

    def load_enviroment(file = nil)
      file ||= "."

      if File.directory?(file) && File.exists?(File.expand_path("#{file}/config/environment.rb"))
        require "rails"
        require File.expand_path("#{file}/config/environment.rb")
        if defined?(::Rails) && ::Rails.respond_to?(:application)
          # Rails 3
          ::Rails.application.eager_load!
        elsif defined?(::Rails::Initializer)
          # Rails 2.3
          $rails_rake_task = false
          ::Rails::Initializer.run :load_application_classes
        end
      elsif File.file?(file)
        require File.expand_path(file)
      end
    end
  end
end
