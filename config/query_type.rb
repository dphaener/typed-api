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

      field :todos do
        type -> { types[::Graph::Container::TodoType] }
        resolve -> (obj, args, ctx) {
          Repositories::Todos.new(ctx[:db]).all
        }
      end

      field :todo_lists do
        type -> { types[::Graph::Container::TodoListType] }
        resolve -> (obj, args, ctx) {
          Repositories::TodoLists.new(ctx[:db]).all
        }
      end
    end
  end
end

