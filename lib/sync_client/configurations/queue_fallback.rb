module SyncClient
  module Configurations
    class QueueFallback
      attr_reader :queue
      attr_reader :url

      def initialize(queue, url)
        @name = name
        @url = url
      end
    end
  end
end
