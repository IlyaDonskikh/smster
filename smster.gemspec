$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "smster/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "smster"
  s.version     = Smster::VERSION
  s.authors     = ["doniv"]
  s.email       = ["donivrecord@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "SMS service"
  s.description = "Multi provider sms service"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4"
  s.add_dependency 'rest-client'

  s.add_development_dependency "sqlite3"
end
