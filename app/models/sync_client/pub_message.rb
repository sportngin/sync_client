module SyncClient
  class PubMessage < Message

    def publish
      Resque.enqueue(Jobs::SyncClientJobs::Publish, self)
    end

    def synchronous_publish
      queues.each do |queue|
        Queuel.with(queue_with_suffix(queue)).push self.to_json
      end
    end

    def to_json
      {:action => action, :object_type => object_type_with_service, :object_attributes => object_attributes}.to_json
    end

    def object_type_with_service
      service = Rails.application.class.parent_name
      "#{service}::#{self.object_type}"
    end

    def queue_with_suffix(queue)
      SyncClient.queue_suffix ? "#{queue}_#{SyncClient.queue_suffix}" : queue
    end
  end
end
