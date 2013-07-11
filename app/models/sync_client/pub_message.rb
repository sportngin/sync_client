module SyncClient
  class PubMessage < Message

    def publish
      Resque.enqueue(Jobs::SyncClientJobs::Publish, self)
    end

    def synchronous_publish
      Queuel.with(queue_with_suffix).push self.package
    end

    def package
      {:action => action, :object_type => object_type_with_service, :object_attributes => object_attributes}
    end

    def object_type_with_service
      service = Rails.application.class.parent_name
      "#{service}::#{self.object_type}"
    end

    def queue_with_suffix
      SyncClient.queue_suffix ? "#{queue}_#{SyncClient.queue_suffix}" : queue
    end
  end
end
