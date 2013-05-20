class Game < SyncClient::ServiceResource::Base
  attr_accessor :name
  attr_accessor :id

  def create
    return true
  end

  def update
    return true
  end
end
