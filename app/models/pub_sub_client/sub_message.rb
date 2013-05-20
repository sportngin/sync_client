module PubSubClient
  class SubMessage < Message
    def process
      message_handler = ::PubSubClient.handlers[object_type]
      if message_handler and message_handler.actions.include?(action)
        message_handler.handler.new(self.object_attributes).send(action)
      else
        # TODO: log invalid message
        # Return false so message is not deleted from the queue
        false
      end
    end
  end
end
