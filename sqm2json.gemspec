# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sqm2json/version'

Gem::Specification.new do |spec|
  spec.name          = 'sqm2json'
  spec.version       = Sqm2Json::VERSION
  spec.authors       = ['Nicolas FLINOIS']
  spec.email         = ['nicolas.flinois@gmail.com']
  spec.license       = 'WTFPL v2'

  spec.summary       = 'This library aims at converting Arma\'s missions SQM format to JSON and vice-versa'
  spec.description   = 'The conversion of SQM format to JSON document and vice versa makes missions parsing easier: ' \
                    'you can either browse your mission content, or modify it and generate a new valid mission.sqm file'
  spec.homepage      = 'https://github.com/nicolasFlinois/sqm2json'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7'
  spec.add_development_dependency 'bundler', '~> 2.4'
  spec.add_development_dependency 'rake', '~> 13.2'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'yard', '~> 0.9'
end
