require 'sync_client/configurators/message_handlers'
module SyncClient
  class Configurator
    private
    attr_writer :message_handlers
    attr_writer :logger

    public
    attr_reader :message_handlers
    attr_reader :logger

    ACTIONS = [:create, :update, :destroy]

    def initialize
      self.message_handlers = Configurators::MessageHandlers.new
      self.logger = Rails.logger
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
  end
end
