# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'async_event_emitter/version'

Gem::Specification.new do |spec|
  spec.name          = "async_event_emitter"
  spec.version       = AsyncEventEmitter::VERSION
  spec.authors       = ["Nikolay Bienko"]
  spec.email         = ["bikolya@gmail.com"]

  spec.summary       = %q{EventEmitter allows to asynchronously notify subscribers about events}
  spec.description   = %q{With EventEmitter you can build your application in Event-Driven way. It acts as global pub/sub mechanism and uses Sidekiq to reliably and asynchronously deliver messages to subscribers. Using this approach you can enforce low coupling between different components of the system.}
  spec.homepage      = "https://github.com/bikolya/async_event_emitter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sidekiq", ">= 3", "< 5"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
