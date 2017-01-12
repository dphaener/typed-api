require "graphql"

class QueryType
  def call
    GraphQL::ObjectType.define do
      name "QueryType"
      description "The query root of this schema"

      field :users do
        type -> { types[::Graph::Container::UserType] }
        resolve -> (obj, args, ctx) {
          Repositories::Users.new(ctx[:db]).all
        }
      end

      field :user do
        argument :id, types.ID
        type -> { ::Graph::Container::UserType }
        resolve -> (obj, args, ctx) {
          Repositories::Users.new(ctx[:db]).by_id(args[:id])
        }
      end
    end
  end
end

