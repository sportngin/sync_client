module SyncClient
  class DelayedJob
    def self.enqueue(job, message)
      job.delay.perform(message.instance_values)
    end
  end
end
