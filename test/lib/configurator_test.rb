require 'test_helper'

class ConfiguratorTest < ActiveSupport::TestCase
  context "Configurator" do
    describe PubSubClient::Configurator do
      it { should respond_to(:queuel)}
    end

    should "set handlers and actions" do
      assert_equal ['Dummy::Game'], PubSubClient.handlers.keys
      assert_equal [:update, :create, :destroy], PubSubClient.handlers['Dummy::Game'].actions
    end
  end
end
