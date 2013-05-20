class Game < SyncClient::ServiceResource::Base
  field :name

  def create
    return true
  end

  def update
    return true
  end
end
