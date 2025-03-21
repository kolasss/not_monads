# frozen_string_literal: true

require_relative 'lib/not_monads/version'

Gem::Specification.new do |spec|
  spec.name = 'not_monads'
  spec.version = NotMonads::VERSION
  spec.authors = ['kolas']
  spec.email = ['kolas.krytoi@gmail.com']

  spec.summary = 'Simple service objects'
  spec.description = 'Simple copy of [dry-monads](https://github.com/dry-rb/dry-monads) do monads, it implements only mixin for your service object and Success/Failure result object.' # rubocop:disable Layout/LineLength
  spec.homepage = 'https://github.com/kolasss/not_monads'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/kolasss/not_monads'
  spec.metadata['changelog_uri'] = 'https://github.com/kolasss/not_monads/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do # rubocop:disable ThreadSafety/DirChdir
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ tmp/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  # spec.add_development_dependency "bundler"
  spec.metadata['rubygems_mfa_required'] = 'true'
end
