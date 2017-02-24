# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'facturapi/version'

Gem::Specification.new do |spec|
  spec.name          = "facturapi"
  spec.version       = Facturapi::VERSION
  spec.authors       = ["Alter Lagos"]
  spec.email         = ["alter.strife@gmail.com"]

  spec.summary       = %q{Ruby integration with facturacion.cl service}
  spec.homepage      = "https://github.com/meloncargo/facturapi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "savon", "~> 2.0"
  spec.add_runtime_dependency "libxml-ruby", "~> 2.0"
  spec.add_runtime_dependency "nokogiri", "~> 1.4", ">= 1.4.0"
  spec.add_runtime_dependency "i18n", "~> 0.6"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug", "~> 3.4.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7.0"
end
