require 'test_helper'

class PubMessageTest < ActiveSupport::TestCase
  context "PubMessage" do
    context "ClassMethods" do
      setup do
        @player = Player.create(:name => 'joe')
        @message = @player.queue_message(:action)
      end

      should "queue publish" do
        Resque.expects(:enqueue).with(Jobs::SyncClientJobs::PublisherJob, @message.attributes).returns(true)
        @message.publish
      end

      should "copy object queues" do
        assert_not_nil @message.queues
        assert_equal @player.class.pub_queues, @message.queues
      end

      should "wrap object type with service" do
        assert_equal "Dummy::Player", @message.object_type_with_service
      end

      should "push message to queues" do
        queuel = Queuel.with(@message.queues.first)
        Queuel.expects(:with).with(@message.queues.first).once.returns(queuel)
        @message.synchronous_publish
      end

    end
  end
end
