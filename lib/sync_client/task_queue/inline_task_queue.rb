module SyncClient
  class InlineTaskQueue
    def self.enqueue(job, message)
      job.perform(message.instance_values)
    end
  end
end
