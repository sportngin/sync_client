require 'queuel'
namespace :sync_client do
  task :setup

  desc "Start a queue poller"
  task :poll => :setup do
    ::Queuel.receive do |message|
      begin
        if message and message.body
          puts "recieved message: #{message}"
          success = false
          success = SyncClient::SubMessage.new(JSON.parse(message.body)).process
          puts "finished with: #{!!success}"
          !!success
        end
      rescue Exception => e
        puts "exception occrued: #{e.message}"
        puts "exception occrued: #{e.backtrace}"
        # TODO log failure
        # return false to requeue the message, perhaps in failure queue
        false
      end
    end
  end
end
