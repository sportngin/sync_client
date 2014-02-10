require 'sync_client/publisher/base'

module SyncClient
  module Publisher
    module ActiveRecordPublisher
      extend ActiveSupport::Concern
      included do
        include SyncClient::Publisher::Base
      end

      def any_attributes_changed?(attributes)
        attributes.any?{|attr| send("#{attr}_changed?")}
      end

      def publisher_attributes
        self.attributes
      end
    end
  end
end
