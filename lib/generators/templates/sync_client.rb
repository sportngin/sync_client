SyncClient.config do |config|

  config.queuel do |c|
    # c.default_queue 'VenueService'
    # c.credentials token: 'asdufasdf8a7sd8fa7sdf', project_id: 'project_id'
    # c.engine :iron_mq
  end
  # config.task_queue Resque
  # config.queue_suffix 'suffix'
  # config.logger Logger.new
  # config.add_message_object_handler object_name, handler_class, actions
  # config.add_message_object_handler 'StatNgin::Game', 'Resource::StatNgin::Game', [:update, :create, :destroy]
end
