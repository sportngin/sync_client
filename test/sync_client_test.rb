require 'test_helper'

class SyncClientTest < ActiveSupport::TestCase
  context "SyncClient" do

    describe SyncClient do
      it { should respond_to(:config)}
      it { config.should be_a SyncClient::Configurtor}
    end

  end
end
