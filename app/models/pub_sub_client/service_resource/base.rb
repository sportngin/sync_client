module PubSubClient
  module ServiceResource
    class Base < Typhoid::Resource
      field :attribute_hash


      # add logic to handle params
      def initialize(attrs)
        self.attribute_hash = attrs
      end

      def create
        raise NotImplementedError
      end

      def update
        raise NotImplementedError
      end

      def destroy
        raise NotImplementedError
      end
    end
  end
end
