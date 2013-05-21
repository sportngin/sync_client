require 'sync_client/publisher'
require 'sync_client/version'
require "sync_client/engine"
require 'sync_client/configurator'
require 'queuel'
require 'mono_logger'

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
    config.logger
  end
end
