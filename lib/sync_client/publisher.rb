require 'sync_client/publisher/active_record_publisher'
require 'sync_client/publisher/mongoid_publisher'
require 'sync_client/publisher/poro_publisher'

module SyncClient
  module Publisher
    extend ActiveSupport::Concern

    included do
      if defined?(::ActiveRecord::Base) && self <= ::ActiveRecord::Base
        include SyncClient::Publisher::ActiveRecordPublisher
      elsif defined?(::Mongoid::Document) && self.included_modules.include?(::Mongoid::Document)
        include SyncClient::Publisher::MongoidPublisher
      else
        include SyncClient::Publisher::PoroPublisher
      end
    end
  end
end

