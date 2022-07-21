# frozen_string_literal: true

require_relative "lib/containers/version"

Gem::Specification.new do |gem|
  gem.name = "containers"
  gem.version = Containers::VERSION
  gem.authors = ["Hopsoft"]
  gem.email = ["natehop@gmail.com"]

  gem.summary = "Manage local development environments with Docker"
  gem.description = "Manage local development environments with Docker"
  gem.homepage = "https://github.com/hopsoft/containers"
  gem.license = "MIT"
  gem.required_ruby_version = ">= 2.6.0"

  # gem.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  gem.metadata["homepage_uri"] = gem.homepage
  gem.metadata["source_code_uri"] = gem.homepage
  gem.metadata["changelog_uri"] = "#{gem.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gem.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  gem.bindir = "exe"
  gem.executables = gem.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency "rainbow", "~> 3.1.1"
  gem.add_dependency "thor", "~> 1.2.1"

  gem.add_development_dependency "github_changelog_generator", "~> 1.16.4"
  gem.add_development_dependency "ruby_jard", "~> 0.3.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
