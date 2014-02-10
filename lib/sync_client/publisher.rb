require 'sync_client/publisher/active_record'
require 'sync_client/publisher/mongoid'
require 'sync_client/publisher/poro'

module SyncClient
  module Publisher
    extend ActiveSupport::Concern

    included do
      if defined?(::ActiveRecord::Base) && self <= ::ActiveRecord::Base
        include SyncClient::Publisher::ActiveRecord
      elsif defined?(::Mongoid::Document) && self.included_modules.include?(::Mongoid::Document)
        include SyncClient::Publisher::Mongoid
      else
        include SyncClient::Publisher::Poro
      end
    end
  end
end

