require 'test_helper'

class ActiveRecordClass < ActiveRecord::Base
  include SyncClient::Publisher::ActiveRecord

  self.table_name = :players
  publish_changes_of :name, :to => :test
end

class ActiveRecordPublisherTest < ActiveSupport::TestCase
  context "ActiveRecord::Publisher" do
    context "ClassMethods" do
      subject { ActiveRecordClass }

      should "respond to queue_publisher with defined resource" do
        assert_not_nil subject.queue_publisher.sync_queues
      end

      should "setup an after_create callback" do
        assert subject._create_callbacks.any? {|cb| cb.filter == :publish_create and cb.kind == :after },
               'after_create :publish_create was not added'
      end

      should "setup a before_update callback" do
        assert subject._update_callbacks.any? {|cb| cb.filter == :publish_update and cb.kind == :before },
               'after_create :publish_update was not added'
      end

      should "setup an after_destroy callback" do
        assert subject._destroy_callbacks.any? {|cb| cb.filter == :publish_destroy and cb.kind == :after },
               'after_destroy :publish_destroy was not added'
      end
    end

    context "InstanceMethods" do
      subject { ActiveRecordClass.new }

      setup do
        @publisher = SyncClient::QueuePublisher.new
        subject.stubs(:queue_publisher).returns(@publisher)
      end

      context "#publish_create" do
        should 'send #publish to queue_publisher with :create' do
          @publisher.expects(:publish).with(:create, subject).returns(true)
          subject.publish_create
        end
      end

      context "#publish_update" do
        should 'send #publish to queue_publisher with :update' do
          @publisher.expects(:publish).with(:update, subject).returns(true)
          subject.publish_update
        end
      end

      context "#publish_destroy" do
        should 'send #publish to queue_publisher with :destroy' do
          @publisher.expects(:publish).with(:destroy, subject).returns(true)
          subject.publish_destroy
        end
      end

      context "#any_attributes_changed?" do
        should 'return true if an attribute has changed' do
          subject.name = 'Nick'
          assert_equal true, subject.any_attributes_changed?([:name])
        end

        should 'return false if no attributes have changed' do
          assert_equal false, subject.any_attributes_changed?([:name])
        end
      end

      context "#publisher_attributes" do
        should 'return the attributes hash' do
          assert_equal subject.attributes, subject.publisher_attributes
        end
      end
    end
  end
end
