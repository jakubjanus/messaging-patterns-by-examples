# frozen_string_literal: true

require_relative "lib/infra/version"

Gem::Specification.new do |spec|
  spec.name = "infra"
  spec.version = Infra::VERSION
  spec.authors = ["Jakub Janus"]
  spec.email = ["jakubjanus90@gmail.com"]

  spec.summary = "Infrastructure & messaging"
  spec.description = "Infrastructure code for example apps"
  spec.homepage = "https://github.com/jakubjanus/messaging-patterns-by-examples/infra"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'dry-struct', '>= 1.6.0'
  spec.add_dependency 'karafka', '>= 2.0.0'

  spec.add_development_dependency 'pry-byebug', '~> 3.10.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
end
