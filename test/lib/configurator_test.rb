require 'test_helper'

class ConfiguratorTest < ActiveSupport::TestCase
  context "Configurator" do
    describe SyncClient::Configurator do
      it { should respond_to(:queuel)}
    end

    should "set handlers and actions" do
      assert_equal ['Dummy::Game'], SyncClient.handlers.keys
      assert_equal [:update, :create, :destroy], SyncClient.handlers['Dummy::Game'].actions
    end
  end
end
