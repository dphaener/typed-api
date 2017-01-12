require "graphql"

class MutationType
  def call
    GraphQL::ObjectType.define do
      name "MutationType"
      description "The mutation root of this schema"

      field :createUser, ::Graph::Container::CreateUserMutation
      field :updateUser, ::Graph::Container::UpdateUserMutation
      field :destroyUser, ::Graph::Container::DestroyUserMutation

      field :createTodo, ::Graph::Container::CreateTodoMutation
      field :updateTodo, ::Graph::Container::UpdateTodoMutation
      field :destroyTodo, ::Graph::Container::DestroyTodoMutation
    end
  end
end
