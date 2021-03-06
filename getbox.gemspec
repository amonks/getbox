# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'getbox/version'

Gem::Specification.new do |spec|
  spec.name          = "getbox"
  spec.version       = Getbox::VERSION
  spec.authors       = ["Andrew Monks"]
  spec.email         = ["a@monks.co"]

  spec.summary       = %q{Scrape your Gistbox page to export your label data.}
  spec.homepage      = "http://github.com/amonks/getbox"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   = ['getbox']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "capybara", "~> 2.4"
  spec.add_runtime_dependency "capybara-webkit", "~> 1.5"
  spec.add_runtime_dependency "nokogiri", "~>1.6"
end
