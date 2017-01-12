require_relative "todo"

class User < ApiType
  description "A user of this todo app"

  attribute :id, Types::Strict::Int
  attribute :email, Types::Email
  attribute :first_name, Types::Strict::String
  attribute :last_name, Types::Strict::String

  attribute :todos, Types::Strict::Array.member(Todo)
end
