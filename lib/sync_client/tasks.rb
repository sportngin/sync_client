require 'queuel'
namespace :sync_client do
  task :setup

  desc "Start a queue poller"
  task :poll => :setup do
    ::Queuel.receive do |message|
      begin
        if message and message.body
          SyncClient.logger.info("recieved message: #{message}")
          success = false
          success = SyncClient::SubMessage.new(JSON.parse(message.body)).process
          SyncClient.logger.info("finished with: #{!!success}")
          !!success
        end
      rescue Exception => e
        SyncClient.logger.error("#{e.message} \n #{e.backtrace}")
        false
      end
    end
  end
end
