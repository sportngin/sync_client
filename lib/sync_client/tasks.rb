require 'queuel'
namespace :sync_client do
  task :setup

  desc "Start a queue poller"
  task :poll => :setup do
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
