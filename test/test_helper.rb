# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'test/unit'
require 'shoulda'
require 'simplecov'
require 'sync_client'
SimpleCov.start 'rails'

Rails.backtrace_cleaner.remove_silencers!

ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'
ActiveRecord::Schema.define do
  create_table :players, :force => true do |t|
    t.string :name
    t.integer :id
  end

  create_table :games, :force => true do |t|
    t.string :name
    t.integer :id
  end
end
