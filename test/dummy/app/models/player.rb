class Player < ActiveRecord::Base
  include SyncClient::Publisher
  publish_changes_of :name, :id, to: :dummy

  def puts_name
    puts name
  end
end
