module Jobs
  module SyncClientJobs
    class Publish
      include Resque::Plugins::UniqueJob
      extend ::Resque::Metrics

      @queue = :high

      def self.perform(message)
        SyncClient::PubMessage.new(message).synchronous_publish
      end
    end
  end
end
