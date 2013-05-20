require 'queuel'
namespace :sync_client do
  task :setup

  desc "Start a queue poller"
  task :poll => :setup do
    ::Queuel.receive do |message|
      begin
        puts "recieved message: #{message}"
        process = nil
        if message and message.body
          process = SyncClient::SubMessage.new(JSON.parse(message.body)).process
        end
        puts "finished with: #{process}"
        return process
      rescue Exception => e
        puts "exception occrued: #{message}"
        puts "exception occrued: #{e}"
        # TODO log failure
        # return false to requeue the message, perhaps in failure queue
        false
      end
    end
  end
end
