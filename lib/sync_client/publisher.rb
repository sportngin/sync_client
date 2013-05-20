module SyncClient
  module Publisher
    extend ActiveSupport::Concern

    included do
      after_update :publish_update
      after_destroy :publish_destroy
      after_create :publish_create
    end

    module ClassMethods
      def publish_changes_of(*attributes, queue)
        @queue_attributes = {} unless @queue_attributes
        @pub_queues = [] unless @pub_queues

        queue = queue[:to]
        @queue_attributes[queue] = attributes
        @pub_queues << queue
      end

      attr_reader :queue_attributes
      attr_reader :pub_queues
    end

    def publish_update
      queues = []
      self.class.queue_attributes.each do |queue, attributes|
        queues << queue if attributes.any?{|attr| self.send("#{attr}_changed?")}
      end
      queue_message(:update, queues).publish unless queues.empty?
    end

    def publish_destroy
      queue_message(:destroy).publish
    end

    def publish_create
      queue_message(:create).publish
    end

    def queue_message(action, queues = self.class.pub_queues)
      SyncClient::PubMessage.new(
        :queues => queues,
        :action => action,
        :object_type => self.class.to_s,
        :object_attributes => self.attributes)
    end
  end
end

