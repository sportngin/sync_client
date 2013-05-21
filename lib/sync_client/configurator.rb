require 'sync_client/configurators/message_handlers'
module SyncClient
  class Configurator
    private
    attr_writer :message_handlers
    attr_writer :logger
    attr_writer :queue_suffix

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

    def add_queue_suffix(queue_suffix)
      self.queue_suffix = queue_suffix
    end

    def handlers
      message_handlers.message_handlers
    end
  end
end
