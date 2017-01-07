require "dry-container"

require_relative "query"
require_relative "schema"
require_relative "types"
require_relative "../import"

module Graph
  class Container
    extend Dry::Container::Mixin

    Import["persistence.db"]

    TYPES = Dir["./types/*.rb"]

    register("query") { Graph::Query.new }
    register("types") { Graph::Types.new }

    resolve("types").(TYPES)
  end
end
