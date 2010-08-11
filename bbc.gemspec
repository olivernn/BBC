# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bbc'

Gem::Specification.new do |s|
  s.name        = "bbc"
  s.version     = BBC::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Oliver Nightingale"]
  s.email       = ["oliver.n@new-bamboo.co.uk"]
  s.homepage    = "http://github.com/olivernn/bbc"
  s.summary     = "Ruby Library to interact with the BBC APIs"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "json"

  s.add_development_dependency "shoulda"
  s.add_development_dependency "webmock"
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
end