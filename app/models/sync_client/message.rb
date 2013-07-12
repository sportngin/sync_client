module SyncClient
  class Message
    attr_accessor :action
    attr_accessor :object_type
    attr_accessor :queue
    attr_accessor :object_attributes

    def initialize(attrs)
      attrs = {} unless attrs
      attrs.each do |key, value|
        send("#{key}=", value) if self.respond_to?("#{key}=")
      end
    end
  end
end
