$:.push File.expand_path("../lib", __FILE__)

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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "resque"
  s.add_dependency "thor"

  s.add_development_dependency "simplecov"
  s.add_development_dependency 'shoulda'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mocha"
  s.add_development_dependency 'debugger'
end
