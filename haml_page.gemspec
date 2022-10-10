# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'haml_page/version'

Gem::Specification.new do |spec|
  spec.name        = "haml_page"
  spec.version     = HamlPage::VERSION
  spec.authors     = ["Kenneth Leung"]
  spec.email       = ["info@leungs.us"]
  spec.summary     = %q{This gem will generate a web page (.html) based on given Haml layout and view.}
  spec.description = %q{This gem will generate a web page (.html) based on given Haml layout and view.}
  spec.homepage    = ""
  spec.license     = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'haml', '~>5'
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
