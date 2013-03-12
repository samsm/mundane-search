# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mundane-search/version'

Gem::Specification.new do |gem|
  gem.name          = "mundane-search"
  gem.version       = MundaneSearch::VERSION
  gem.authors       = ["Sam Schenkman-Moore"]
  gem.email         = ["samsm@samsm.com"]
  gem.description   = %q{Makes everyday search easy-ish.}
  gem.summary       = %q{Makes everyday search easy-ish.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "activemodel"

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "activerecord"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "database_cleaner"

end
