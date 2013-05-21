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
        ::Rails.application.eager_load!
      elsif File.file?(file)
        require File.expand_path(file)
      end
    end
  end
end
