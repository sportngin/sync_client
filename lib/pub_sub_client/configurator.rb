require 'pub_sub_client/configurators/message_handlers'
module PubSubClient
  class Configurator
    private
    attr_writer :message_handlers

    public
    attr_reader :message_handlers

    ACTIONS = [:create, :update, :destroy]

    def initialize
      self.message_handlers = Configurators::MessageHandlers.new
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
