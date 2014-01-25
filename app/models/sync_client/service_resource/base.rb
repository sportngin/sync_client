module SyncClient
  module ServiceResource
    class Base
      attr_accessor :error

      # add logic to handle params
      def initialize(attrs)
        attrs = {} unless attrs
        attrs.each do |key, value|
          send("#{key}=", value) if self.respond_to?("#{key}=")
        end
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

      def sync
        raise NotImplementedError
      end
    end
  end
end
