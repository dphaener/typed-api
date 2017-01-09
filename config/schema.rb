require "graphql"

require_relative "query_type"

class Schema
  def call
    GraphQL::Schema.define do
      query QueryType.new.call
    end
  end
end
