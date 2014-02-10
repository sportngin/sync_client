require 'sync_client/publisher/base'

module SyncClient
  module Publisher
    module Mongoid
      extend ActiveSupport::Concern

      included do
        include SyncClient::Publisher::Base
      end

      def any_attributes_changed?(attributes)
        attributes.any?{|attr| send("#{attr}_changed?")}
      end

      def publisher_attributes
        self.attributes.inject({}) { |attrs, (raw_key, raw_value)|
          if raw_key =='_id'
            attrs['id'] = raw_value
          else
            attrs[self.aliased_fields.invert.fetch(raw_key) { raw_key }] = raw_value
          end
          attrs
        }
      end
    end
  end
end
