# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sqm2json/version'

Gem::Specification.new do |spec|
  spec.name          = 'sqm2json'
  spec.version       = Sqm2Json::VERSION
  spec.authors       = ['Nicolas FLINOIS']
  spec.email         = ['nicolas.flinois@gmail.com']
  spec.license       = 'WTFPL v2'

  spec.summary       = %q{This library aims at converting Arma's missions SQM format to JSON and vice-versa}
  spec.description   = %q{The conversion of SQM format to JSON document and vice versa makes missions parsing easier: you can either browse your mission content, or modify it and generate a new valid mission.sqm file}
  spec.homepage      = 'https://github.com/nicolasFlinois/sqm2json'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard', '~> 0.8.7.6'

end

