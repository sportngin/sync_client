class Game < PubSubClient::ServiceResource::Base
  field :id
  field :name

  def create
    return true
  end

  def update
    return true
  end

  def destroy
    return false
  end
end
