require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  context "Publisher" do
    context "ClassMethods" do
      setup do
        @player = Player.new
      end

      should "respond to queue_publisher with defined resource" do
        assert_not_nil @player.queue_publisher.sync_queues
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

    context "PORO (Plain Old Ruby Object)" do
      subject { Class.new }

      should 'respond to all the same methods as ActiveRecord::Base object' do
        subject.extend(SyncClient::Publisher)
        assert subject.respond_to?(:queue_publisher), "PORO didn't respond to queue_publisher"
        assert subject.respond_to?(:publish_update), "PORO didn't respond to publish_update"
        assert subject.respond_to?(:publish_destroy), "PORO didn't respond to publish_destroy"
        assert subject.respond_to?(:publish_create), "PORO didn't respond to publish_create"
        assert subject.respond_to?(:publisher_attributes), "PORO didn't respond to publisher_attributes"
      end
    end
  end
end
