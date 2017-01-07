require "dry-container"
require "dry-auto_inject"

require_relative "register_type"
require_relative "coerce_type"

module Graph
  class Helpers
    extend Dry::Container::Mixin

    register("register_type") { Graph::RegisterType.new }
    register("coerce_type") { Graph::CoerceType.new }

    register("explain") do
      -> (schema) { schema.execute GraphQL::Introspection::INTROSPECTION_QUERY }
    end

    register("generate") do
      -> (schema, destination) {
        result = JSON.pretty_generate(explain(schema))
        unless File.exists?(destination) && File.read(destination) == result
          File.write(destination, result)
        end
      }
    end
  end
end

Graph::Helpers::Import = Dry::AutoInject(Graph::Helpers)
