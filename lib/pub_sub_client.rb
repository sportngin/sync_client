require 'pub_sub_client/publisher'
require 'pub_sub_client/version'
require "pub_sub_client/engine"
require 'pub_sub_client/configurator'
require 'queuel'

module PubSubClient
  def self.version_string
    "PubSubClient version #{PubSubClient::VERSION}"
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
end
