require_relative 'lib/superdeduper/version'

Gem::Specification.new do |spec|
  spec.name          = 'superdeduper'
  spec.version       = Superdeduper::VERSION
  spec.authors       = ['mrichardsJBOIT']
  spec.email         = ['14255080+mrichardsJBOIT@users.noreply.github.com']

  spec.summary       = %q{Finds files which have exactly the same contents and outputs any duplicates.}
  spec.description   = %q{Coding excerise to write a command-line program which finds files that have exactly the
same contents and outputs any duplicates (and their locations) to standard output}
  spec.homepage      = 'https://github.com/mrichardsJBOIT/superdeduper.'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/mrichardsJBOIT/superdeduper.git'
  spec.metadata['changelog_uri'] = 'https://github.com/mrichardsJBOIT/superdeduper/blob/main/changelog.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'aruba', '~> 1.0', '>= 1.0.4'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters', '1.2.0'
  spec.add_development_dependency 'rake', '~> 12.0'

end
