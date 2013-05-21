require 'queuel'
namespace :sync_client do
  task :setup

  desc "Start a queue poller"
  task :poll => :setup do
    ::Queuel.receive do |message|
      begin
        if message and message.body
          SyncClient.logger.info("MQ Log > Recieved Message:\n\t#{message}")
          success = false
          success = SyncClient::SubMessage.new(JSON.parse(message.body)).process
          SyncClient.logger.info("MQ Log > Processed Message:\n\t#{!!success}")
          !!success
        end
      rescue Exception => e
        SyncClient.logger.error("MQ Log > Exception Occurred:\n\t#{e.message}\n\t#{e.backtrace}")
        false
      end
    end
  end
end
