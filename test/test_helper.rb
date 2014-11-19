# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'simplecov'
require 'simplecov-gem-adapter'

SimpleCov.start 'gem'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'test/unit'
require 'shoulda'
require 'sync_client'


Rails.backtrace_cleaner.remove_silencers!

ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'
ActiveRecord::Schema.define do
  create_table :players, :force => true do |t|
    t.string :name
  end

  create_table :games, :force => true do |t|
    t.string :name
  end
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending! if Rails::VERSION::MAJOR >= 4
  include Shoulda::Matchers::ActiveRecord
  extend Shoulda::Matchers::ActiveRecord
  include Shoulda::Matchers::ActiveModel
  extend Shoulda::Matchers::ActiveModel
end

class ActiveSupport::TestCase
  setup do
    ::SyncClient.logger.stubs(:warn).returns(:true)
    ::SyncClient.logger.stubs(:info).returns(:true)
  end
end

