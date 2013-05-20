class Game < SyncClient::ServiceResource::Base
  attr_accessor :name

  def create
    return true
  end

  def update
    return true
  end
end
