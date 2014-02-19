module SyncClient
  class Worker
    def work
      puts "starting queuel worker"
      ::Queuel.receive do |message|
        begin
          if message and message.body
            SyncClient::SubMessage.new(message.body).process || SyncClient.logger.error("Message failed to process #{message.body}")
          else
            SyncClient.logger.error("Message invalid: #{message}")
          end
        rescue StandardError => e
          SyncClient.logger.error("Exception Occurred:\n\t#{e.message}\n\t#{e.backtrace}")
          false
        end
      end
    end
  end
end
