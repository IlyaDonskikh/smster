$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "smster/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "smster"
  s.version     = Smster::VERSION
  s.authors     = ["doniv"]
  s.email       = ["donivrecord@gmail.com"]
  s.homepage    = "https://github.com/IlyaDonskikh/smster"
  s.summary     = "SMS service"
  s.description = "SMS sending service through different providers with maximum convenience."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4'
  s.add_dependency 'rest-client', '~> 1.8'
  s.add_dependency 'smster_ruby', '1.0.0'

  s.add_development_dependency 'sqlite3'
end
