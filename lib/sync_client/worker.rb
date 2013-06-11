module SyncClient
  class Worker
    def work
      SyncClient.logger.info("+++++++++++++++++++++++++++++")
      SyncClient.logger.info("Starting Message Queue Worker")
      SyncClient.logger.info("+++++++++++++++++++++++++++++")
      ::Queuel.receive do |message|
        begin
          SyncClient::SubMessage.new(message.body).process if message and message.body
        rescue Exception => e
          SyncClient.logger.error("Exception Occurred:\n\t#{e.message}\n\t#{e.backtrace}")
          true
        end
      end
    end
  end
end
