module PubSubClient
  class PubMessage < Message

    def publish
      Resque.enqueue(Jobs::PubSubClientJobs::PublisherJob, self.attributes)
    end

    def synchronous_publish
      queues.each do |queue|
        Queuel.with(queue).push self.to_json
      end
    end

    def to_json
      {:action => action, :object_type => object_type_with_service, :object_attributes => object_attributes}.to_json
    end

    def object_type_with_service
      service = Rails.application.class.parent_name
      "#{service}::#{attributes['object_type']}"
    end
  end
end
