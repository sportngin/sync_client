$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pub_sub_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pub_sub_client"
  s.version     = PubSubClient::VERSION
  s.authors     = ["Bryce Schmidt"]
  s.email       = ["bryce.schmidt@sportngin.com"]
  s.homepage    = "http://www.sportngin.com"
  s.summary     = "TODO: Summary of PubSubClient."
  s.description = "TODO: Description of PubSubClient."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "typhoid"
  s.add_dependency "iron_mq"

  s.add_development_dependency "simplecov"
  s.add_development_dependency 'shoulda'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mocha"
end
