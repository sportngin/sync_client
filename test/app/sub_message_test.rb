require 'test_helper'

class SubMessageTest < ActiveSupport::TestCase
  context "SubMessage" do
    context "ClassMethods" do
      setup do
        @message = ::PubSubClient::SubMessage.new(:object_type => 'Dummy::Game', :action => :update)
      end

      should "send action to valid message" do
        assert_equal true, @message.process
      end

      should "skip message object " do
        @message.object_type = 'invalid'
        assert_equal false, @message.process
      end

      should "skip message action" do
        @message.action = 'invalid'
        assert_equal false, @message.process
      end
    end
  end
end
