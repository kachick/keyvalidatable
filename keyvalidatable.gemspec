Gem::Specification.new do |gem|
  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.summary       = %q{Validate shortage/excess keys in pairs.}
  gem.description   = gem.summary.dup
  gem.homepage      = 'https://github.com/kachick/keyvalidatable'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'keyvalidatable'
  gem.require_paths = ['lib']
  gem.version       = '0.0.5'

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_development_dependency 'test-declare', '~> 0.0.2.1'
  gem.add_development_dependency 'yard', '~> 0.8'
end

