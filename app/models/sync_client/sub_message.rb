module SyncClient
  class SubMessage < Message
    attr_accessor :success

    def process
      with_logging do
        self.success = message_handler.send(action.to_sym) if handler_present?
      end
      !!success
    end

    def handler_present?
      return true if handler_class and handler_class.actions.include?(action.to_sym)
      self.success = true #still setting to true to remove message from queue
      return false
    end

    def handler_class
      ::SyncClient.handlers[object_type]
    end

    def message_handler
      @handler ||= handler_class.handler.new(object_attributes)
    end

    def error
      message_handler.error if handler_class and message_handler.error
    end

    def with_logging(&block)
      SyncClient.logger.info("------------------------------------------")
      SyncClient.logger.info("Recieved Message: #{object_type}##{action}")
      yield
      SyncClient.logger.info("Error Occured: #{error}") if error
      SyncClient.logger.info("Processed Message: #{!!success}")
    end
  end
end
