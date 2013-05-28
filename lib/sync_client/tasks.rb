require 'queuel'
namespace :sync_client do
  task :setup

  desc "Start a queue poller"
  task :poll => :setup do
    SyncClient::Worker.new.work
  end
end
