require "dry/system/container"

require_relative "lib/types"
require_relative "lib/api_type"

repos = Dir["./app/repositories/*"]
types = Dir["./app/types/*"]

repos.each { |repo| require repo }
types.each { |type| require type }

class TypedAPI < Dry::System::Container
  configure do |config|
    config.auto_register = %w(lib app/repositories app/types)

    load_paths!('lib')
  end
end
