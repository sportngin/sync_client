module SyncClient
  class HttpSync
    attr_accessor :url

    def self.with(fallback)
      SyncClient::HttpSync.new(fallback)
    end

    def initialize(queue_fallback)
      @url = fallback.url
    end

    def push(message)
      Typhoeus.post(url, followlocation: true, body: message)
    end
  end
end