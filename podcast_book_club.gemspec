lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "podcast_book_club/version"

Gem::Specification.new do |spec|
  spec.name          = "podcast-book-club"
  spec.version       = PodcastBookClub::VERSION
  spec.authors       = ["jessrezac"]
  spec.email         = ["jess.rezac@gmail.com"]

  spec.summary       = %q{The Ezra Klein Show book recommendations.}
  spec.description   = %q{Explore books recommended by guests on The Ezra Klein Show on Vox.}
  spec.homepage      = "https://github.com/jessrezac/podcast-book-club"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jessrezac/podcast-book-club"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.12.2"

  spec.add_dependency "nokogiri", "~> 1.6", ">= 1.6.8"
  spec.add_dependency "googlebooks", "~> 0.0.9"
end
