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

  gem.files = Dir["lib/**/*", "sig/**/*", "exe/**/*"]
  gem.bindir = "exe"
  gem.executables = gem.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency "activesupport", ">= 6.0"
  gem.add_dependency "rainbow", ">= 3.1"
  gem.add_dependency "rake"
  gem.add_dependency "thor", ">= 1.2"

  gem.add_development_dependency "magic_frozen_string_literal"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "pry-byebug"
  gem.add_development_dependency "standardrb"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
