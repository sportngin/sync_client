require 'mongoid'

class Stat
  include ::Mongoid::Document
  include SyncClient::Publisher

  publish_changes_of :values, :to => :test

  field :pid, :as => :player_id
  field :values, :type => Hash
end
