module SyncClient
  class SubMessage < Message
    def process
      if message_handler and message_handler.actions.include?(action.to_sym)
        return message_handler_class.send(action.to_sym)
      else
        # TODO: log invalid message
        puts "==========================="
        puts "message handler not defined"
        puts "#{object_type} | #{action}"
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
