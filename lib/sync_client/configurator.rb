require 'sync_client/configurators/message_handlers'
require 'sync_client/configurators/queue_fallbacks'
require 'sync_client/task_queue/delayed_job'
require 'sync_client/task_queue/resque'
require 'sync_client/task_queue/inline_task_queue'

module SyncClient
  class Configurator
    private
    attr_writer :message_handlers
    attr_writer :queue_fallbacks
    attr_writer :suffix
    attr_writer :sync_logger
    attr_writer :task_queue

    public
    attr_reader :message_handlers
    attr_reader :queue_fallbacks
    attr_reader :sync_logger
    attr_reader :suffix
    attr_reader :task_queue

    ACTIONS = [:create, :update, :destroy]

    def initialize
      self.message_handlers = Configurators::MessageHandlers.new
      self.queue_fallbacks = Configurators::QueueFallbacks.new
      self.sync_logger = Logger.new(STDOUT)
      self.task_queue = SyncClient::InlineTaskQueue
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

    def add_queue_fallback(queue, url)
      queue_fallbacks.add_queue_fallback queue, url
    end

    def fallbacks
      queue_fallbacks.queue_fallbacks
    end

    def queue_suffix(queue_suffix)
      self.suffix = queue_suffix
    end

    def logger(logger)
      self.sync_logger = logger
    end

    def background_task_queue(queue)
      self.task_queue = queue
    end

  end
end
