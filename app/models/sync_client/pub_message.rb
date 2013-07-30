module SyncClient
  class PubMessage < Message

    def publish
      SyncClient.background_task_queue.enqueue(Jobs::SyncClientJobs::Publish, self)
    end

    def synchronous_publish
      with_logging do
        Queuel.with(queue_with_suffix).push package
      end
    end

    def package
      {:action => action, :object_type => object_type_with_service, :object_attributes => object_attributes}
    end

    def object_type_with_service
      service = Rails.application.class.parent_name
      "#{service}::#{object_type}"
    end

    def queue_with_suffix
      SyncClient.queue_suffix.blank? ? queue.to_s : "#{queue}_#{SyncClient.queue_suffix}"
    end

    def with_logging(&block)
      SyncClient.logger.info("------------------------------------------")
      SyncClient.logger.info("Publishing Message: #{object_type}##{action}")
      SyncClient.logger.info("To: #{queue_with_suffix}")
      yield
    end
  end
end
