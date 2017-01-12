require "graphql"

require_relative "query_type"
require_relative "mutation_type"

class Schema
  def call
    GraphQL::Schema.define do
      query QueryType.new.call
      mutation MutationType.new.call

      max_depth 10
      max_complexity 200
    end
  end
end
