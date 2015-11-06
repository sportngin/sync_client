# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require "sync_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sync_client"
  s.version     = SyncClient::VERSION
  s.authors     = ["Bryce Schmidt"]
  s.email       = ["bryce.schmidt@sportngin.com"]
  s.homepage    = "http://www.sportngin.com"
  s.summary     = "Interface to keep attributes synchronized between services using a message queue"
  s.description = "SyncClient is an interface for synchronizing attributes between services.
    It provides both a means of publishing changes and subscribing to them"
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport', "> 3.0"
  s.add_dependency 'railties', "> 3.0"
  s.add_dependency "queuel", "~> 0.4.6"
  s.add_dependency "daemons", "~> 1.1.9"

  s.add_development_dependency 'activerecord', "> 3.0"
  s.add_development_dependency 'mongoid', '~> 4.0.0.alpha'
  s.add_development_dependency 'shoulda', "~> 3.5.0"
  s.add_development_dependency "sqlite3", "~> 1.3.8"
  s.add_development_dependency "minitest", "~> 4.0"
  s.add_development_dependency "test-unit" # Work around Ruby 2.2 and ActiveSupport bug
  s.add_development_dependency "mocha", "~> 0.14.0"
  s.add_development_dependency "rdoc", "~> 4.0.1"
  s.add_development_dependency "simplecov", "> 0.7.0"
  s.add_development_dependency 'simplecov-gem-adapter', "> 1.0.0"
  s.add_development_dependency "coveralls", "> 0.7.0"
end
