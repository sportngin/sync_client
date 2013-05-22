module SyncClient
  class Worker
    def work
      ::Queuel.receive do |message|
        begin
          SyncClient::SubMessage.new(JSON.parse(message.body)).process if message and message.body
        rescue Exception => e
          SyncClient.logger.error("Exception Occurred:\n\t#{e.message}\n\t#{e.backtrace}")
          false
        end
      end
    end
  end
end
