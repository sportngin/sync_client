require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  context "Publisher" do
    context "ClassMethods" do
      setup do
        @player = Player.new
      end

      should "respond to meta_resource_name with defined resource" do
        assert_equal 1, @player.queue_publisher.sync_queue.count
      end

    end

    context "InstanceMethods" do
      setup do
        @new_player = Player.new(:name => "Joe")
        @player = Player.create(:name => 'foo')
        @message = SyncClient::PubMessage.new(:action => :create)

        @message.stubs(:queue_publisher).returns(true)
      end

      should "publish on create" do

      end

      should "publish on destoy" do

      end

      should "publish on update" do
      end

    end
  end
end
