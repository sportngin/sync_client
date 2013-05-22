SyncClient.config do |config|

  config.queuel do |c|
    c.default_queue 'dummy'
    # c.credentials token: 'dI7zSWHX1aTffU4QmQjwb15Li2g', project_id: '518a63022267d86cd3000599'
    # c.engine :iron_mq
  end

  # config.add_message_object_handler object_name, handler_class, actions
  config.add_message_handler 'Dummy::Game', 'Game', [:update, :create, :destroy]
end
