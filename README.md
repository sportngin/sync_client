# SyncClient
[![Build Status][build_status_image]][build_status]
[![Coverage Status][coverage_status_image]][coverage_status]

This gem simplifies syncing data between services by using delayed job processing and a message queue for guaranteed delivery and eventual consistency. SyncClient defines messages based on a resource and action system to simplify message publishing and handling. It supports inline processing and delayed job processeding by Resque, DelayedJob, and Sidekiq. See [Queuel](https://rubygems.org/gems/sync_client) for a list of supported message queues.


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

## Configuration

SyncClient requires that message queue creditials, a background task queue, and message handler definitions to be defined in the configuration file. Note that any message that does not match a defined handler is simply dropped from the queue.

```ruby
SyncClient.config do |config|

  config.queuel do |c|
    # c.default_queue 'VenueService'
    # c.credentials token: [token], project_id: 'project_id'
    # c.engine :iron_mq
  end
  # config.background_task_queue SyncClient::Resque #or SyncClient::DelayedJob or write your own.
  # config.queue_suffix 'suffix'
  # config.logger Logger.new
  # config.add_message_handler object_name, handler_class, actions
  # config.add_message_handler 'Service::Game', 'Service::Game', [:update, :create, :destroy]
end
```


## Usage

### Publisher

SyncClient provides a simple interface to define what attributes to publish to a service for associated actions where the message class is the class of the resource. For models that inherit from `ActiveRecord::Base` or include `Mongoid::Document`, add the `SyncClient::Publisher` module and configure like the following:

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

The `sync` method is mapped to the `:sync` action in the ServiceResource by
default, but `:create`, `:update` and `:destroy` are still available for you to
use as well.


### Poller

Run the message queue poller:

```bash
$ bundle exec script/sync_client start
$ bundle exec script/sync_client status
$ bundle exec script/sync_client restart
$ bundle exec script/sync_client stop
```


### Service Resource

Message handlers for the actions are then defined matching the handler class set in the configuration file where each method corresponds to the message action as follows:

```ruby
module Service
  class Game < SyncClient::ServiceResource::Base
  
    # Determine what attributes are to be accessible using attr_accessors
    attr_accessor :id
    attr_accessor :starts_at
    attr_accessor :ends_at
  
    def create
      Game.create(:game_id => self.id, :starts_at => self.starts_at, :ends_at =>  self.ends_at)
    end
  
    def update
      game = Game.find(self.id).first
      game.update_attributes(:starts_at => self.starts_at, :ends_at => self.  ends_at)
    end
  
    def destroy
      game = Game.find(self.id)
      game.destroy
    end
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sync_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[build_status]: https://travis-ci.org/sportngin/sync_client
[build_status_image]: https://travis-ci.org/sportngin/sync_client.svg?branch=master
[coverage_status]: https://coveralls.io/r/sportngin/sync_client
[coverage_status_image]: https://img.shields.io/coveralls/sportngin/sync_client.svg

