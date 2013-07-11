module SyncClient
  class SyncQueue
    attr_accessor :attributes
    attr_accessor :queue
    attr_accessor :callbacks
    attr_accessor :options

    def initialize(attributes, options)
      @attributes = attributes
      @queue = options[:to]
      @callbacks = options[:for] || [:update, :save, :destroy]
      @options = options
    end
  end
end
