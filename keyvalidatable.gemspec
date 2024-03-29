# coding: us-ascii
# frozen_string_literal: true

lib_name = 'keyvalidatable'

require_relative './lib/keyvalidatable/version'
repository_url = "https://github.com/kachick/#{lib_name}"

Gem::Specification.new do |gem|
  gem.summary       = %q{Validate shortage/excess keys in pairs}
  gem.description   = <<-'DESCRIPTION'
    Validate shortage/excess keys in pairs
  DESCRIPTION
  gem.homepage      = repository_url
  gem.license       = 'MIT'
  gem.name          = lib_name
  gem.version       = KeyValidatable::VERSION

  gem.metadata = {
    'documentation_uri' => 'https://kachick.github.io/keyvalidatable/',
    'homepage_uri'      => repository_url,
    'source_code_uri'   => repository_url,
    'bug_tracker_uri'   => "#{repository_url}/issues",
    'rubygems_mfa_required' => 'true'
  }

  gem.add_development_dependency 'declare', '>= 0.3.0', '< 0.4.0'
  gem.add_development_dependency 'irb', '>= 1.3.5', '< 2.0'
  gem.add_development_dependency 'irb-power_assert', '0.0.2'
  gem.add_development_dependency 'warning', '>= 1.2.0', '< 2.0'
  gem.add_development_dependency 'rake', '>= 13.0.3', '< 20.0'
  gem.add_development_dependency 'yard', '>= 0.9.26', '< 2'
  gem.add_development_dependency 'rubocop', '>= 1.15.0', '< 1.30.0'
  gem.add_development_dependency 'rubocop-rake', '>= 0.5.1', '< 0.7.0'
  gem.add_development_dependency 'rubocop-performance', '>= 1.11.3', '< 1.14.0'
  gem.add_development_dependency 'rubocop-rubycw', '>= 0.1.6', '< 0.2.0'
  gem.add_development_dependency 'rubocop-md', '>= 1.0.1', '< 2.0.0'

  gem.required_ruby_version = Gem::Requirement.new('>= 2.5.0', '< 3.1.0')

  # common

  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  git_managed_files = `git ls-files`.lines.map(&:chomp)
  might_be_parsing_by_tool_as_dependabot = git_managed_files.empty?
  base_files = Dir['README*', '*LICENSE*',  'lib/**/*', 'sig/**/*'].uniq
  files = might_be_parsing_by_tool_as_dependabot ? base_files : (base_files & git_managed_files)

  unless might_be_parsing_by_tool_as_dependabot
    if files.grep(%r!\A(?:lib|sig)/!).size < 2
      raise "obvious mistaken in packaging files, looks shortage: #{files.inspect}"
    end
  end

  gem.files         = files
  gem.require_paths = ['lib']
end
