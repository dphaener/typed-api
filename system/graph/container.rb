require "dry-container"

require_relative "query"
require_relative "types"
require_relative "../import"
require_relative "../../config/schema"

module Graph
  class Container
    extend Dry::Container::Mixin

    Import["persistence.db"]

    TYPES = Dir["./app/types/*"]

    register("query") { Graph::Query.new }
    register("types") { Graph::Types.new }
    register("schema") { Schema.new }

    resolve("types").(TYPES, Graph::Container)
  end
end
