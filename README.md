SyncClient
==========

This gem simplifies syncing data between services by using a resque queue and a
message queue for guaranteed delivery and eventual consistency of data.


Installation
------------

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


Usage
-----

### Publisher

For models that inherit from `ActiveRecord::Base` or include
`Mongoid::Document`, to publish attributes to a service, you want include
something like the following:

```ruby
class Team < ActiveRecord::Base
  include SyncClient::Publisher
  publish_changes_of :name, :color, to: :queue, for: [:update, :destroy], if: lambda{|team| !team.name.nil?}
    # options:
    #   to: name of queue for publishing (required)
    #   for: callbacks for publishing (default: :create, :update, :destroy)
    #   if/unless: condition for publishing
end
```

If you are just working with a "Plain Old Ruby Object", you can do something
like this:

```ruby
class TeamSchedulerService
  include SyncClient::Publisher
  publish_to :queue
    # options:
    #   for: callbacks for publishing (default: :sync)
    #   if/unless: condition for publishing

  def do_some_stuffs
    # CODEZ
    sync
    # return value
  end
end
```

And then in a seperate method, you are able to call the `sync` method and fire
the queue syncing yourself.

The `sync` action is mapped to the ServiceResource by default, but `:create`,
`:update` and `:destroy` are still availble for you to use as well.


### Poller

A priority is used for publishing to ensure eventual delivery if the message
queue does not respond. Supported priority queues include Delayed Job and
Resque.

Run the message queue poller:

```bash
$ bundle exec script/sync_client start
$ bundle exec script/sync_client status
$ bundle exec script/sync_client restart
$ bundle exec script/sync_client stop
```


### Service Resource

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


