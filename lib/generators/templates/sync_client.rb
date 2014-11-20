SyncClient.config do |config|

  config.queuel do |c|
    # c.default_queue 'VenueService'
    # c.credentials token: [token], project_id: 'project_id'
    # c.engine :iron_mq
  end
  # config.background_task_queue SyncClient::Resque #or SyncClient::DelayedJob or write your own.
  # config.queue_suffix 'suffix'
  # config.logger Logger.new
  # config.add_message_handler object_name, handler_class, actions
  # config.add_message_handler 'StatNgin::Game', 'Resource::StatNgin::Game', [:update, :create, :destroy]
end
