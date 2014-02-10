module SyncClient
  module Publisher
    module Poro
      extend ActiveSupport::Concern

      module ClassMethods
        def publish_to(*args)
          @queue_publisher ||= SyncClient::QueuePublisher.new
          options = args.last.is_a?(Hash) ? args.pop : {:for => :sync}
          args.each do |end_point|
            @queue_publisher.add_publisher([], options.merge(:to => end_point))
          end
        end

        attr_reader :queue_publisher
      end

      def queue_publisher
        self.class.queue_publisher
      end

      def sync(action=:sync)
        queue_publisher.publish(action, self)
      end

      def publisher_attributes
        instance_variable_names.inject({}) do |result, var|
          result.merge Hash[var.gsub('@', ''), instance_variable_get(var)]
        end
      end
    end
  end
end
