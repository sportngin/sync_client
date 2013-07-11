module SyncClient
  class QueuePublisher
    attr_accessor :sync_queue

    def initialize
      self.sync_queue = []
    end

    def add_publisher(attributes, options)
      self.sync_queue << SyncClient::SyncQueue.new(attributes, options)
    end

    def publish(action, object)
      sync_queue.each do |sync_queue|
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
