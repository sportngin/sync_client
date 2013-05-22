require 'thor'
module SyncClient
  class CLI < Thor

    desc("work", "Start processing queue.")
    def work
      load_enviroment()
      SyncClient::Worker.new().work
    end

    protected

    def load_enviroment
      file = "."
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
