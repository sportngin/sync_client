module SyncClient
  class Sidekiq
    def self.enqueue(job, message)
      ::Sidekiq::Client.enqueue(job, message)
    end
  end
end
