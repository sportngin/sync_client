require 'sync_client/configurators/message_handlers'
module SyncClient
  class Configurator
    private
    attr_writer :message_handlers
    attr_writer :queue_suffix
    attr_writer :logger

    public
    attr_reader :message_handlers
    attr_reader :logger
    attr_reader :queue_suffix

    ACTIONS = [:create, :update, :destroy]

    def initialize
      self.message_handlers = Configurators::MessageHandlers.new
      self.logger = Logger.new(STDOUT)
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

    def set_queue_suffix(suffix)
      self.queue_suffix = suffix
    end

    def set_logger(logger)
      self.logger = logger
    end

  end
end
