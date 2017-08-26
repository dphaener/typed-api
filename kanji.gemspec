lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "kanji/version"

Gem::Specification.new do |s|
  s.name              = "kanji"
  s.version           = Kanji::Version
  s.summary           = "A strongly Typed GraphQL API"
  s.authors           = ["Darin Haener"]
  s.email             = ["dphaener@gmail.com"]
  s.homepage          = "https://dphaener.github.com/kanji"
  s.license           = "MIT"
  s.required_ruby_version = ">= 2.0.0"

  s.files = %w'README.rdoc MIT-LICENSE CHANGELOG Rakefile' + Dir['doc/*.rdoc'] + Dir['doc/release_notes/*.txt'] + Dir['{lib,spec}/**/*.rb'] + Dir['spec/views/*'] + Dir['spec/assets/{css/{app.scss,raw.css,no_access.css},js/head/app.js}']

  s.add_dependency "dry-auto_inject"
  s.add_dependency "dry-container"
  s.add_dependency "dry-core"
  s.add_dependency "dry-struct"
  s.add_dependency "dry-system"
  s.add_dependency "dry-types"
  s.add_dependency "dry-validation"
  s.add_dependency "graphql"
  s.add_dependency "pg"
  s.add_dependency "pry"
  s.add_dependency "rake"
  s.add_dependency "roda"
  s.add_dependency "rom"
  s.add_dependency "rom-repository"
  s.add_dependency "rom-sql"
  s.add_dependency "shotgun"
  s.add_dependency "thin"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-graphql_matchers"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "byebug"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "rainbow", "~> 2.2.2"
  s.add_development_dependency "simplecov"
end
