# encoding: utf-8
require File.expand_path('../lib/fcc_reboot/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'faraday', '~> 0.7'
  gem.add_dependency 'faraday_middleware', '~> 0.8'
  gem.add_dependency 'hashie', '~> 1.2'
  gem.add_dependency 'json', '~> 1.6'
  gem.add_dependency 'multi_json', '~> 1.3'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rdiscount'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  gem.authors = ["Dan Melton", "Javier Muniz", "Ryan Resella"]
  gem.description = %q{Wrapper for FCC API}
  gem.email = 'info@codeforamerica.org'
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/codeforamerica/fcc_reboot'
  gem.name = 'fcc_reboot'
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = %q{FCC API Wrapper}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = FccReboot::VERSION
end
