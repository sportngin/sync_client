require 'test_helper'

class PoroPublisherTest < ActiveSupport::TestCase
  context "Poro::Publisher" do
    context "ClassMethods" do
      subject { GamePublisher }

      context "#publish_to" do
        should "create a publisher if one doesn't exist" do
          subject.publish_to :test
          assert_not_nil subject.queue_publisher
        end

        context "with an existing publisher" do
          setup do
            @publisher = SyncClient::QueuePublisher.new
            subject.instance_variable_set(:@queue_publisher, @publisher)
          end

          should 'add a publisher to the queue_publisher' do
            @publisher.expects(:add_publisher).with([], {:to => :test})
            subject.publish_to :test
          end

          should 'add multiple publishers to the queue_publisher' do
            @publisher.expects(:add_publisher).with([], {:to => :test1})
            @publisher.expects(:add_publisher).with([], {:to => :test2})
            subject.publish_to :test1
            subject.publish_to :test2
          end

          should 'add multiple publishers in the same line' do
            @publisher.expects(:add_publisher).with([], {:to => :test1})
            @publisher.expects(:add_publisher).with([], {:to => :test2})
            subject.publish_to :test1, :test2
          end
        end
      end

      should "respond to queue_publisher with defined resource" do
        assert_not_nil subject.queue_publisher.sync_queues
      end
    end
  end

  context "InstanceMethods" do
    subject { GamePublisher.new }

    setup do
      @publisher = SyncClient::QueuePublisher.new
      GamePublisher.stubs(:queue_publisher).returns(@publisher)
    end

    context "#sync" do
      should 'send #publish to queue_publisher with :create' do
        @publisher.expects(:publish).with(:create, subject).returns(true)
        subject.sync
      end
    end

    context "publisher_attributes" do
      should 'include all of the instance variables' do
        subject.instance_variable_set(:@game_id, 123)
        subject.score = "12-21"

        assert_equal({
          'game_id' => 123,
          'score' => '12-21',
        },subject.publisher_attributes)
      end
    end
  end

end
