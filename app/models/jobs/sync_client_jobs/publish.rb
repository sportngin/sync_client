module Jobs
  module SyncClientJobs
    class Publish

      @queue = :high

      def self.perform(message)
        SyncClient::PubMessage.new(message).synchronous_publish
      end
    end
  end
end
