module PubSubClient
  module Configurations
    class MessageHandler
      attr_reader :name
      attr_reader :handler
      attr_reader :actions

      def initialize(name, handler, actions = [])
        @name = name.to_s.singularize
        @handler = handler.classify.constantize
        @actions = actions
      end
    end
  end
end
