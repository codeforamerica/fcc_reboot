# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fcc_reboot/version"

Gem::Specification.new do |s|
  s.name        = "fcc_reboot"
  s.version     = FccReboot::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = "Code for America"
  s.email       = "info@codeforamerica.org"
  s.homepage    = ""
  s.summary     = %q{FCC API Wrapper}
  s.description = %q{Wrapper for FCC API}

  s.rubyforge_project = "fcc_reboot"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('ZenTest', '~> 4.5')
  s.add_development_dependency('maruku', '~> 0.6')
  s.add_development_dependency('rake', '~> 0.8')
  s.add_development_dependency('rspec', '~> 2.5')
  s.add_development_dependency('simplecov', '~> 0.4')
  s.add_development_dependency('yard', '~> 0.6')
  s.add_development_dependency('nokogiri', '~> 1.4')
  s.add_development_dependency('webmock', '~> 1.5')

  s.add_runtime_dependency('hashie', '~> 1.0.0')
  s.add_runtime_dependency('faraday', '~> 0.6.0')
  s.add_runtime_dependency('faraday_middleware', '~> 0.6.0')
  s.add_runtime_dependency('multi_json', '~> 0.0.5')
  s.add_runtime_dependency('multi_xml', '~> 0.2.0')

  s.add_dependency('json', '~>1.5.1')
end
