module SyncClient
  class Resque
    def self.enqueue(job, message)
      Resque.enqueue(job, message)
    end
  end
end
