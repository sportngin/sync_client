require 'thor'
module SyncClient
  class Poller < Thor

    def self.run
      load_enviroment
      SyncClient::Worker.new.work
    end

    private_class_method :new

    protected

    def self.load_enviroment
      require File.expand_path("./config/environment.rb")
      if defined?(::Rails) && ::Rails.respond_to?(:application)
        # Rails 3
        ::Rails.application.eager_load!
      end
    end
  end
end
