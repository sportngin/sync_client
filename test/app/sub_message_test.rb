require 'test_helper'

class SubMessageTest < ActiveSupport::TestCase
  context "SubMessage" do
    context "ClassMethods" do
      setup do
        @message = ::SyncClient::SubMessage.new(
          :object_type => 'Dummy::Game',
          :object_attributes => {:id => 1, :name => 'game', :invalid => 'invalid'},
          :action => :update)

        @message.stubs(:handler).with
      end

      should "send action to valid message" do
        assert_equal true, @message.process
      end

      should "skip message object " do
        @message.object_type = 'invalid'
        assert_equal true, @message.process
      end

      should "skip message action" do
        @message.action = 'invalid'
        assert_equal true, @message.process
      end

      should "create message_handler with attributes" do
        assert_equal Game, @message.handler_class.handler
        assert_equal [:update, :create, :destroy], @message.handler_class.actions
      end

      should "access errors if set" do
        @message.action = 'destroy'
        assert_equal true, @message.process
        assert_not_nil @message.error
      end

    end
  end
end
