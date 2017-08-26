require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require "pathname"
require "pry-byebug"
require "rspec/graphql_matchers"

ENV['RACK_ENV'] ||= 'test'

SPEC_ROOT = Pathname(__FILE__).dirname

require SPEC_ROOT.join("../lib/kanji")

Dir["./lib/kanji/**/*.rb"].each(&method(:require))
Dir["./spec/support/**/*.rb"].each(&method(:require))

RSpec.configure do |config|
  #config.use_transactional_fixtures = false
  #config.infer_spec_type_from_file_location!
  #config.filter_run_excluding ignore: true
end
