require 'test_helper'

class PubMessageTest < ActiveSupport::TestCase
  context "PubMessage" do
    context "ClassMethods" do
      setup do
        @player = Player.create(:name => 'joe')
        queue_publisher = SyncClient::QueuePublisher.new
        @message = queue_publisher.queue_message(:action, @player, 'dummy')
      end

      should "queue publish" do
        SyncClient.background_task_queue.expects(:enqueue).with(Jobs::SyncClientJobs::Publish, @message).returns(true)
        @message.publish
      end

      should "copy object queues" do
        assert_not_nil @message.queue
      end

      should "wrap object type with service" do
        assert_equal "Dummy::Player", @message.object_type_with_service
      end

      should "push message to queues" do
        queuel = Queuel.with(@message.queue)
        Queuel.expects(:with).with(@message.queue).once.returns(queuel)
        @message.synchronous_publish
      end

    end
  end
end
