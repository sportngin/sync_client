module SyncClient
  class Poller

    def self.run
      new.run
    end

    def run
      SyncClient::Worker.new.work
    end
  end
end
