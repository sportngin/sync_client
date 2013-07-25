module SyncClient
  class DelayedJob
    def self.enqueue(job, message)
      job.delay.perform(message)
    end
  end
end
