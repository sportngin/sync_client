module Jobs
  module SyncClientJobs
    class PublisherJob
      include Resque::Plugins::UniqueJob
      extend ::Resque::Metrics

      @queue = :high

      def self.perform(message_attributes)
        message = ::SyncClient::PubMessage.new(message_attributes)
        message.synchronous_publish
      end
    end
  end
end
