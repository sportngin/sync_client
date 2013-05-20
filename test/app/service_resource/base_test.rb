require 'test_helper'

class BaseTest < ActiveSupport::TestCase
  context "Base" do
    context "ClassMethods" do
      setup do
        @game = Game.new(:name => 'game', :id => 1, :invalid => 'sdfas')
      end

      should "respond to meta_resource_name with defined resource" do
        assert_equal 'game', @game.name
        assert_equal 1, @game.id
        assert_equal false, @game.respond_to?(:invalid)
      end

    end
  end
end
