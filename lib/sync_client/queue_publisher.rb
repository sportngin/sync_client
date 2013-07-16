module SyncClient
  class QueuePublisher
    attr_accessor :sync_queues

    def initialize
      self.sync_queues = []
    end

    def add_publisher(attributes, options)
      self.sync_queues << SyncClient::SyncQueue.new(attributes, options)
    end

    def publish(action, object)
      sync_queues.each do |sync_queue|
        SyncClient.logger.warn("sync_queue queue blank: #{sync_queue.inspect}") if sync_queue.queue.blank?
        queue_message(action, object, sync_queue.queue).publish if sync_queue.publishable?(action, object)
      end
    end

    def queue_message(action, object, queue)
      SyncClient::PubMessage.new(
        :queue => queue,
        :action => action,
        :object_type => object.class.to_s,
        :object_attributes => object.publisher_attributes)
    end
  end
end
