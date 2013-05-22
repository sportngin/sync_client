module SyncClient
  class SubMessage < Message
    def process
      success = false
      SyncClient.logger.info("Recieved Message:\n\t#{message}")
      if message_handler and message_handler.actions.include?(action.to_sym)
        success = message_handler_class.send(action.to_sym)
      else
        success = true
        SyncClient.logger.warn("MQ Log > Handler not Defined:\n\t#{object_type}##{action}")
      end
      SyncClient.logger.info("Processed Message:\n\t#{!!success}")
      !!success
    end

    def message_handler
      ::SyncClient.handlers[object_type]
    end

    def message_handler_class
      message_handler.handler.new(self.object_attributes)
    end
  end
end
