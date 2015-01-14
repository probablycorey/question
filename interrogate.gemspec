# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'interrogate/version'

Gem::Specification.new do |spec|
  spec.name          = "interrogate"
  spec.version       = Interrogate::VERSION
  spec.authors       = ["probablycorey"]
  spec.email         = ["probablycorey@gmail.com"]
  spec.summary       = %q{Interactive command line UI.}
  spec.description   = %q{Inspired by Inquirer.js}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"

  s.add_runtime_dependency('colorize', '~> 0.7.5')
end
