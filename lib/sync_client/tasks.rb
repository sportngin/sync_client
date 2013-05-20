require 'queuel'
namespace :sync_client do
  task :setup

  desc "Start a queue poller"
  task :subscribe do
    ::Queuel.receive do |message|
      begin
        SyncClient::SubMessage.new(JSON.parse(message.body)).process
      rescue
        # TODO log failure
        # return false to requeue the message, perhaps in failure queue
        false
      end
    end
  end
end
