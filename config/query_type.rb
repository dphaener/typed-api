require "graphql"

require_relative "../app/types/user/repository"

class QueryType
  def call
    GraphQL::ObjectType.define do
      name "Query"
      description "The query root of this schema"

      field :users do
        type -> { types[::Graph::Container::UserType] }
        resolve -> (obj, args, ctx) {
          Repos::User.new(ctx[:db]).all
        }
      end
    end
  end
end

