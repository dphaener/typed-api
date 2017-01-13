class Todo < ApiType
  description "A todo"

  attribute :id, Types::Strict::Int
  attribute :todo_list_id, Types::Strict::Int
  attribute :title, Types::Strict::String
  attribute :description, Types::Strict::String
  attribute :complete, Types::Form::Bool
end
