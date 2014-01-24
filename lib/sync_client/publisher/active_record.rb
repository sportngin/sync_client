module SyncClient
  module Publisher
    module ActiveRecord
      extend ActiveSupport::Concern

      included do
        after_create :publish_create
        before_update :publish_update
        after_destroy :publish_destroy
      end

      module ClassMethods
        def publish_changes_of(*attributes, options)
          @queue_publisher = SyncClient::QueuePublisher.new unless @queue_publisher
          @queue_publisher.add_publisher(attributes, options)
        end

        attr_reader :queue_publisher
      end

      def queue_publisher
        self.class.queue_publisher
      end

      def publish_create
        queue_publisher.publish(:create, self)
      end

      def publish_update
        queue_publisher.publish(:update, self)
      end

      def publish_destroy
        queue_publisher.publish(:destroy, self)
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
