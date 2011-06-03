# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'vestal_versions/version_num'

Gem::Specification.new do |s|
  s.name        = 'vestal_versions'
  s.version     = VestalVersions::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Adam Cooper"]
  s.email       = ['adam.cooper@gmail.com']
  s.homepage    = 'http://github.com/laserlemon/vestal_versions'
  s.summary     = "Keep a DRY history of your ActiveRecord models' changes"
  s.description = "Keep a DRY history of your ActiveRecord models' changes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = ['lib']

  s.add_dependency 'rails', '~> 3.0.0'

  s.add_development_dependency 'rake', '~> 0.8.7'
  s.add_development_dependency 'rspec', '~> 2.6.0'
  s.add_development_dependency 'sqlite3'
end
