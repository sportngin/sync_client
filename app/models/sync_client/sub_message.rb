module SyncClient
  class SubMessage < Message
    def process
      if message_handler and message_handler.actions.include?(action)
        message_handler_class.send(action)
      else
        # TODO: log invalid message
        # Return false so message is not deleted from the queue
        false
      end
    end

    def message_handler
      ::SyncClient.handlers[object_type]
    end

    def message_handler_class
      message_handler.handler.new(self.object_attributes)
    end
  end
end
