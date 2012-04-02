# -*- encoding: utf-8 -*-
require File.expand_path('../lib/acts_as_authoritah/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Unnikrishnan KP"]
  gem.email         = ["unni.tallman@gmail.com"]
  gem.description   = %q{Define user capabilities in your app}
  gem.summary       = %q{Define user capabilities in your app}
  gem.homepage      = ""
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "acts_as_authoritah"
  gem.require_paths = ["lib"]
  gem.version       = ActsAsAuthoritah::VERSION
end
