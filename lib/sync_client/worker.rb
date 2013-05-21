module SyncClient
  class Worker
    def work
      ::Queuel.receive do |message|
        begin
          if message and message.body
            SyncClient.logger.info("Recieved Message:\n\t#{message}")
            success = false
            success = SyncClient::SubMessage.new(JSON.parse(message.body)).process
            SyncClient.logger.info("Processed Message:\n\t#{!!success}")
            !!success
          end
        rescue Exception => e
          SyncClient.logger.error("Exception Occurred:\n\t#{e.message}\n\t#{e.backtrace}")
          false
        end
      end
    end
  end
end
