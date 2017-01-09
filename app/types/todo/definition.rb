require_relative "../../../system/boot/api_type"

module Todo
  class Type < ApiType
    description "A todo"

    attribute :title, Types::Strict::String
    attribute :description, Types::Strict::String
    attribute :complete, Types::Strict::Bool
  end
end
