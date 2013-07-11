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
        if update?(action, object) and resolve_condition(object, sync_queue.options)
          queue_message(:update, object, sync_queue.queue) if sync_queue.callbacks.include?(action)
        end
      end
    end

    def queue_message(action, object, queue)
      SyncClient::PubMessage.new(
        :queue => queue,
        :action => action,
        :object_type => object.class.to_s,
        :object_attributes => object.publisher_attributes)
    end

    def update?(action, object)
      action != :update || sync_queue.attributes.any?{|attr| object.send("#{attr}_changed?")}
    end

    def resolve_condition(object, options)
      return true if options[:if].nil? && options[:unless].nil?
      result = options[:if] == true || (options[:if].respond_to?(:call) && options[:if].call(object)) if options.has_key?(:if)
      result = options[:unless] == false || (options[:unless].respond_to?(:call) && !options[:unless].call(object)) if options.has_key?(:unless)
      result
    end
  end
end
