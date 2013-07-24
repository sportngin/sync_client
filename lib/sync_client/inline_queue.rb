module SyncClient
  class InlineQueue
    def self.enqueue(job, attributes)
      job.perform(attributes.instance_values)
    end
  end
end
