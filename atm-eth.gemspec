# atm-eth.gemspec
# frozen_string_literal: true

require_relative "lib/atm/eth/version"

Gem::Specification.new do |spec|
  spec.name = "atm-eth"
  spec.version = Atm::Eth::VERSION
  spec.authors = ["Kenzo"]
  spec.email = ["kenzo.tominaga@gmail.com"]

  spec.summary = "Ruby gem for interacting with Ethereum blockchain."
  spec.description = "Simplify Ethereum interactions with this gem."
  spec.homepage = "https://github.com/tominugen/atm-eth"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.4"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tominugen/atm-eth"
  spec.metadata["changelog_uri"] = "https://github.com/tominugen/atm-eth/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end

  spec.files += Dir.glob("lib/**/*.rb")
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rails', '~> 7.0.5'
  spec.add_runtime_dependency "json", "~> 2.5"
  spec.add_runtime_dependency "openssl", "3.1.0"
  spec.add_runtime_dependency "digest", "~> 1.0"
  spec.add_runtime_dependency 'digest-keccak'

end
