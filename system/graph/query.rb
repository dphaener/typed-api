require "graphql"

module Graph
  class Query
    def initialize(types)
      types.each { |type| Graph::Query.const_set(type.name, type) }
    end

    def call(schema:, query:, variables: {}, context: {})
      GraphQL::Query.new(schema, query, variables, context).result
    end
  end
end
