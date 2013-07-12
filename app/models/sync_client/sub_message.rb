module SyncClient
  class SubMessage < Message
    attr_accessor :success
    attr_accessor :error

    def process
      with_logging do
        self.success = message_handler_class.send(action.to_sym) if handler_present?
      end
      !!success
    end

    def handler_present?
      return true if message_handler and message_handler.actions.include?(action.to_sym)
      self.error = "Handler not Defined: #{object_type}##{action}"
      self.success = true #still setting to true to remove message from queue
      return false
    end

    def message_handler
      ::SyncClient.handlers[object_type]
    end

    def message_handler_class
      message_handler.handler.new(object_attributes)
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
