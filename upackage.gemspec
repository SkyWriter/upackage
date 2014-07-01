# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upackage/version'

Gem::Specification.new do |spec|
  spec.name          = "upackage"
  spec.version       = Upackage::VERSION
  spec.authors       = ["Ivan Kasatenko"]
  spec.email         = ["sky.31338@gmail.com"]
  spec.summary       = %q{Debian packaging for Ruby and Ruby on Rails applications}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = 'upackage'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
