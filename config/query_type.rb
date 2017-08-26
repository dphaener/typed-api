require "graphql"

class QueryType
  def call
    GraphQL::ObjectType.define do
      name "QueryType"
      description "The query root of this schema"

      # Put your root queries here
    end
  end
end

