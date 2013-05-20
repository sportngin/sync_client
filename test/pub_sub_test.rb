require 'test_helper'

class PubSubClientTest < ActiveSupport::TestCase
  context "PubSubClient" do

    describe PubSubClient do
      it { should respond_to(:config)}
      it { config.should be_a PubSubClient::Configurtor}
    end

  end
end
