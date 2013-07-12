module SyncClient
  class SyncQueue
    attr_accessor :attributes
    attr_accessor :queue
    attr_accessor :callbacks
    attr_accessor :options

    CALLBACK_DEFAULTS = [:update, :create, :destroy]

    def initialize(attributes, options)
      @attributes = attributes
      @queue = options[:to]
      @callbacks = options[:for] || CALLBACK_DEFAULTS
      @options = options
    end

    def publishable?(action, object)
      callbacks.include?(action) and update?(action, object) and resolve_condition(object)
    end

    def update?(action, object)
      action.to_s != 'update' || attributes.any?{|attr| object.send("#{attr}_changed?")}
    end

    def resolve_condition(object)
      return true if options[:if].nil? && options[:unless].nil?
      result = options[:if] == true || (options[:if].respond_to?(:call) && options[:if].call(object)) if options.has_key?(:if)
      result = options[:unless] == false || (options[:unless].respond_to?(:call) && !options[:unless].call(object)) if options.has_key?(:unless)
      result
    end
  end
end
