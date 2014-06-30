module SyncClient
  module Publisher
    module BasePublisher
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

      def publish_create(options = {})
        queue_publisher.publish(:create, self, options)
      end

      def publish_update(options = {})
        queue_publisher.publish(:update, self, options)
      end

      def publish_destroy(options = {})
        queue_publisher.publish(:destroy, self, options)
      end
    end
  end
end

