require 'test_helper'

class QueuePublisherTest < ActiveSupport::TestCase
  context "QueuePublisher" do
    context "Methods" do
      setup do
        @publisher = SyncClient::QueuePublisher.new
        @player = Player.create
        @message = SyncClient::PubMessage.new(:queue => 'foo')

        attributes = [:name]
        options = {to: 'foo', for: [:update, :create], if: lambda{|a| a == a} }
        @publisher.add_publisher(attributes, options)
      end

      should "initialize with sync_queue" do
        assert_not_nil @publisher.sync_queues
      end

      should "add sync queues with attributes and options" do
        assert_equal [:name], @publisher.sync_queues.first.attributes
      end

      should "queue message on publish" do
        @sync_queue = @publisher.sync_queues.first
        @sync_queue.stubs(:publishable?).returns(:true)
        @publisher.expects(:queue_message).with(:create, @player, 'foo').returns(@message)
        @message.expects(:publish).returns(true)

        @publisher.publish(:create, @player)
      end
    end
  end
end
