SyncClient.config do |config|

  config.queuel do |c|
    c.default_queue 'Dummy'
    # c.credentials token: 'asdufasdf8a7sd8fa7sdf', project_id: 'project_id'
    # c.engine :iron_mq
  end
  config.background_task_queue SyncClient::InlineTaskQueue
  config.queue_suffix ''
  config.logger Logger.new(STDOUT)
  
  # config.add_message_object_handler object_name, handler_class, actions
  config.add_message_handler 'Dummy::Game', 'Game', [:update, :create, :destroy]
end
