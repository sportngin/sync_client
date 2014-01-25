class GamePublisher
  include SyncClient::Publisher

  attr_reader :game_id, :result
  attr_accessor :score
end
