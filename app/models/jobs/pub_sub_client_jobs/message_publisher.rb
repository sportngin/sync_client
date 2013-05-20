module Jobs
  module PubSubClientJobs
    class PublisherJob
      include Resque::Plugins::UniqueJob
      extend ::Resque::Metrics

      @queue = :high

      def self.perform(message_attributes)
        message = ::PubSubClient::PubMessage.new(message_attributes)
        message.synchronous_publish
      end
    end
  end
end
