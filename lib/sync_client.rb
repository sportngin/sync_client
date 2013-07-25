require 'rails'
require 'queuel'

require 'sync_client/publisher'
require 'sync_client/queue_publisher'
require 'sync_client/sync_queue'
require 'sync_client/version'
require "sync_client/engine"
require 'sync_client/configurator'
require 'sync_client/worker'
require 'sync_client/poller'
require 'sync_client/inline_queue'

module SyncClient

  def self.version_string
    "SyncClient version #{SyncClient::VERSION}"
  end

  def self.config
    @config ||= Configurator.new
    if block_given?
      yield @config
    end
    @config
  end

  def self.handlers
    config.handlers
  end

  def self.actions
    Configurator::ACTIONS
  end

  def self.logger
    config.sync_logger
  end

  def self.queue_suffix
    config.suffix
  end

  def self.task_queue
    config.task_queue
  end
end
