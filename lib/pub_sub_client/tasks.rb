require 'queuel'
namespace :pub_sub_client do
  task :setup

  desc "Start a queue poller"
  task :subscribe do
    ::Queuel.receive do |message|
      begin
        PubSubClient::SubMessage.new(JSON.parse(message.body)).process
      rescue
        # TODO log failure
        # return false to requeue the message, perhaps in failure queue
        false
      end
    end
  end
end
