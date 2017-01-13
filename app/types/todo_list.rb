require_relative "todo"

class TodoList < ApiType
  description "A todo list"

  attribute :id, Types::Strict::Int
  attribute :title, Types::Strict::String
  attribute :user_id, Types::Strict::Int

  attribute :todos, Types::Strict::Array.member(Todo).default([])
end
