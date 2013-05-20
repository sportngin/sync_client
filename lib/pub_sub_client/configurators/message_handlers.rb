require 'pub_sub_client/configurations/message_handler'
module PubSubClient
  module Configurators
    class MessageHandlers
      attr_reader :message_handlers
      def initialize
        @message_handlers = {}.with_indifferent_access
      end

      def add_message_handler(name, handler, actions)
        message_handlers[name] ||= Configurations::MessageHandler.new(name, handler, actions)
      end
    end
  end
end
