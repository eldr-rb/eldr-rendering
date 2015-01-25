# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eldr/rendering/version'

Gem::Specification.new do |spec|
  spec.name          = 'eldr-rendering'
  spec.version       = Eldr::Rendering::VERSION
  spec.authors       = ['K-2052']
  spec.email         = ['k@2052.me']
  spec.summary       = %q{Template helpers for Eldr apps and compatible Rack apps}
  spec.homepage      = 'https://github.com/eldr-rb/eldr-rendering'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'eldr',          '~> 0.0'
  spec.add_dependency 'tilt',          '~> 1.4'
  spec.add_dependency 'activesupport', '~> 4.2'

  spec.add_development_dependency 'bundler',             '~> 1.7'
  spec.add_development_dependency 'rake',                '10.4.2'
  spec.add_development_dependency 'rspec',               '3.1.0'
  spec.add_development_dependency 'rubocop',             '0.28.0'
  spec.add_development_dependency 'rack-test',           '0.6.3'
  spec.add_development_dependency 'coveralls',           '~> 0.7'
  spec.add_development_dependency 'slim',                '3.0.1'
  spec.add_development_dependency 'rspec-html-matchers', '0.6.1'
end
