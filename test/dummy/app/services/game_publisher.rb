class GamePublisher
  include SyncClient::Publisher::Poro

  attr_reader :game_id, :result
  attr_accessor :score
end
