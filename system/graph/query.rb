require "graphql"

require_relative "../import"

module Graph
  class Query
    include Import["persistence.db"]

    def call(schema:, query:, variables: {}, context: {})
      GraphQL::Query.new(
        schema.call,
        query,
        variables: variables,
        context: context.merge(db: db)
      ).result
    end
  end
end
