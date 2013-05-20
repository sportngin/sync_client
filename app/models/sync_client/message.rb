module SyncClient
  class Message < Typhoid::Resource
    field :action
    field :object_type
    field :queues
    field :object_attributes

    def initialize(attributes)
      attributes.symbolize_keys!
      object_type = attributes[:object_type]
      self.queues = attributes[:queues]
      self.action = attributes[:action]
      self.object_type = object_type
      self.object_attributes = attributes[:object_attributes]
    end
  end
end
