require 'sync_client/configurators/message_handlers'
module SyncClient
  class Configurator
    private
    attr_writer :message_handlers
    attr_writer :suffix
    attr_writer :sync_logger
    attr_writer :task_queue

    public
    attr_reader :message_handlers
    attr_reader :sync_logger
    attr_reader :suffix
    attr_reader :task_queue

    ACTIONS = [:create, :update, :destroy]

    def initialize
      self.message_handlers = Configurators::MessageHandlers.new
      self.sync_logger = Logger.new(STDOUT)
      self.task_queue = SyncClient::InlineQueue
    end

    def queuel
      ::Queuel.configure { |c| yield c }
    end

    def add_message_handler(message, handler, actions)
      message_handlers.add_message_handler message, handler, actions
    end

    def handlers
      message_handlers.message_handlers
    end

    def queue_suffix(queue_suffix)
      self.suffix = queue_suffix
    end

    def logger(logger)
      self.sync_logger = logger
    end

    def background_task_queue(queue)
      self.task_queue = queue.constantize
    end

  end
end
