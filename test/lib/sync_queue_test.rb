require 'test_helper'

class SyncQueueTest < ActiveSupport::TestCase
  context "SyncQueue" do
    context "Initialize" do
      should 'force callbacks into an array' do
        sync_queue = SyncClient::SyncQueue.new([:name], :to => :test, :for => :create)
        assert_equal [:create], sync_queue.callbacks
      end
    end

    context "Methods" do
      setup do
        @attributes = [:name]
        @queue = 'foo'
        @sync_queue = SyncClient::SyncQueue.new(@attributes, {to: @queue})
        @player = Player.create
      end

      should "initialize with attributes" do
        assert_equal @attributes, @sync_queue.attributes
        assert_equal @queue, @sync_queue.queue
        assert_equal SyncClient::SyncQueue::CALLBACK_DEFAULTS, @sync_queue.callbacks
      end

      should "be publishable if create or destroy when default" do
        @sync_queue.stubs(:resolve_conditions).returns(:true)
        assert_equal true, @sync_queue.publishable?(:create, @player)
        assert_equal true, @sync_queue.publishable?(:destroy, @player)
      end

      should "be publishable for update if attributes have not changed" do
        assert_equal false, @sync_queue.publishable?(:update, @player)
      end

      should "be publishable for update if attributes have changed" do
        @player.name = 'john'
        assert_equal true, @sync_queue.publishable?(:update, @player)
      end

      should "resolve_conditions if true" do
        @player.name = 'john'
        @sync_queue.options[:if] = lambda{|a| a.name = @player.name}
        @sync_queue.resolve_condition(@player)
      end

      should "resolve_conditions unless false" do
        @player.name = 'john'
        @sync_queue.options[:unless] = lambda{|a| a.name != @player.name}
        @sync_queue.resolve_condition(@player)
      end

      should "not resolve_conditions if true" do
        @player.name = 'john'
        @sync_queue.options[:if] = lambda{|a| a.name != @player.name}
        @sync_queue.resolve_condition(@player)
      end

      should "not resolve_conditions unless false" do
        @player.name = 'john'
        @sync_queue.options[:unless] = lambda{|a| a.name = @player.name}
        @sync_queue.resolve_condition(@player)
      end

    end
  end
end
