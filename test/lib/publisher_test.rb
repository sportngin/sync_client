require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  context "Publisher" do
    context "ClassMethods" do
      setup do
        @player = Player.new
      end

      should "respond to queue_publisher with defined resource" do
        assert_not_nil @player.queue_publisher.sync_queue
      end

    end

    context "InstanceMethods" do
      setup do
        @new_player = Player.new(:name => "Joe")
        @player = Player.create(:name => 'foo')
        @publisher = SyncClient::QueuePublisher.new
      end

      should "publish on create" do
        @new_player.stubs(:queue_publisher).returns(@publisher)
        @publisher.expects(:publish).with(:create, @new_player).returns(true)
        @new_player.save
      end

      should "publish on destoy" do
        @player.stubs(:queue_publisher).returns(@publisher)
        @publisher.expects(:publish).with(:destroy, @player).returns(true)
        @player.destroy
      end

      should "publish on update" do
        @player.stubs(:queue_publisher).returns(@publisher)
        @publisher.expects(:publish).with(:update, @player).returns(true)
        @player.save
      end

    end
  end
end
