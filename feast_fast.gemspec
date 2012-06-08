# -*- encoding: utf-8 -*-
require File.expand_path('../lib/feast_fast/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ilzoff"]
  gem.email         = ["il.zoff@gmail.com"]
  gem.description   = %q{Feasts and Fasts of Eastern Orthodox Church hardcoded and calculated based on easter.}
  gem.summary       = %q{Feasts and Fasts of Eastern Orthodox Church hardcoded and calculated}
  gem.homepage      = "https://github.com/ilzoff/feast_fast"

  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "feast_fast"
  gem.require_paths = ["lib"]
  gem.version       = FeastFast::VERSION
end
