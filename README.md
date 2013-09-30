# SyncClient

This gem simplifies syncing data between services by using a resque queue and a message queue for guaranteed delivery and eventual consistency of data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sync_client'
```

And then execute:

```bash
$ bundle
```

Then setup your app as a client (if it isn't already):

```bash
$ rails g sync_client:install
```

Edit configuation in `config/initializers/sync_client.rb`

## Usage

Within the model you want to publish attributes to a service include something like the following:

```ruby
class Team
  include SyncClient::Publisher
  publish_changes_of :name, :color, to: :queue, for: [:update, :destroy], if: lambda{|team| !team.name.nil?}
    # options:
    #   to: name of queue for publishing (required)
    #   for: callbacks for publishing (default: :create, :update, :destroy)
    #   if/unless: condition for publishing
end
```


A priority is used for publishing to ensure eventual delivery if the message queue does not respond. Supported priority queues include Delayed Job and Resque.

Run the message queue poller:

```bash
$ bundle exec script/sync_client start
$ bundle exec script/sync_client status
$ bundle exec script/sync_client restart
$ bundle exec script/sync_client stop
```

Define handlers for the all messages such as the following:

```ruby
class Game < SyncClient::ServiceResource::Base
  attr_accessor :id
  attr_accessor :starts_at
  attr_accessor :ends_at

  def create
    Game.create(:game_id => self.id, :starts_at => self.starts_at, :ends_at => self.ends_at)
  end

  def update
    game = Game.find(self.id).first
    game.update_attributes(:starts_at => self.starts_at, :ends_at => self.ends_at)
  end

  def destroy
    game = Game.find(self.id)
    game.each do |ga|
      ga.destroy
    end
  end
end
```


