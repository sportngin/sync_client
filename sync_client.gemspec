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
    It provides both a means of publishing changes and subscibing to them"
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport', "> 3.0"
  s.add_dependency 'railties', "> 3.0"
  s.add_dependency "queuel", "~> 0.2.0"
  s.add_dependency "daemons", "~> 1.1.9"

  s.add_development_dependency 'activerecord', "> 3.0"
  s.add_development_dependency 'mongoid', '~> 4.0.0.alpha'
  s.add_development_dependency "simplecov"
  s.add_development_dependency 'shoulda'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rdoc"
  s.add_development_dependency 'debugger'
end
