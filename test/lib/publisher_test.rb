require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  context "Publisher" do
    context "ClassMethods" do
      setup do
        @player = Player.new
      end

      should "respond to meta_resource_name with defined resource" do
        assert_equal :dummy, @player.class.queue_attributes.keys.first
        assert_equal [:name, :id], @player.class.queue_attributes[:dummy]
      end

    end

    context "InstanceMethods" do
      setup do
        @new_player = Player.new(:name => "Joe")
        @player = Player.create(:name => 'foo')
        @message = SyncClient::PubMessage.new(:action => :create)
        @message.stubs(:publish).returns(true)
      end

      should "publish on create" do
        @new_player.expects(:queue_message).with(:create).returns(@message)
        @new_player.save
      end

      should "publish on destoy" do
        @new_player.expects(:queue_message).with(:destroy).returns(@message)
        @new_player.destroy
      end

      should "publish on update" do
        @player.expects(:queue_message).with(:update, [:dummy]).returns(@message)
        @player.update_attributes({:name => 'sam'})
      end

    end
  end
end
