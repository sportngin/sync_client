require 'sync_client/configurations/queue_fallback'
module SyncClient
  module Configurators
    class QueueFallbacks
      attr_reader :queue_fallbacks

      def initialize
        @queue_fallbacks = {}.with_indifferent_access
      end

      def add_http_fallback(queue, url)
        queue_fallbacks[queue] ||= Configurations::QueueFallback.new(queue, url)
      end
    end
  end
end
