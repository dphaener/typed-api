require_relative "todo_list"

class User < ApiType
  description "A user of this todo app"

  attribute :id, Types::Strict::Int
  attribute :email, Types::Email
  attribute :first_name, Types::Strict::String
  attribute :last_name, Types::Strict::String

  attribute :todo_lists, Types::Strict::Array.member(TodoList).default([])
end
