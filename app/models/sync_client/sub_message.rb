module SyncClient
  class SubMessage < Message
    def process
      if message_handler and message_handler.actions.include?(action.to_sym)
        return message_handler_class.send(action.to_sym)
      else
        # Logging handler not define, but return true to remove msg from queue
        SyncClient.logger.warn("message handler not defined #{object_type} | #{action}")
        true
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
