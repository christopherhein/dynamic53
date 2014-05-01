# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dynamic53/version'

Gem::Specification.new do |spec|
  spec.name          = "dynamic53"
  spec.version       = Dynamic53::VERSION
  spec.authors       = ["Christopher Hein"]
  spec.email         = ["me@christopherhein.com"]
  spec.description   = %q{Setup dynamic dns service using Route 53 and Ruby}
  spec.summary       = %q{Simple ruby executable that will allow you to setup 'dynamic dns' to a local network like dyndns or any other dynamic dns service using Route 53 and Ruby}
  spec.homepage      = "https://github.com/christopherhein/dynamic53"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "route53"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
