$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "wake/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "wake"
  s.version     = Wake::VERSION
  s.authors     = ["rndrfero"]
  s.email       = ["frantisek.psotka@stylez.sk"]
  s.homepage    = "https://github.com/rndrfero/wake"
  s.summary     = "Convention-over-configuration extension for Rails. Rapid prototyping THE FINAL application. Opposite to scaffolding."
  s.description = "Convention-over-configuration extension for Rails. Rapid prototyping THE FINAL application. Opposite to scaffolding."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
#  s.add_dependency "will_paginate", "~> 3.0"
#  s.add_dependency "kaminari"
  
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
