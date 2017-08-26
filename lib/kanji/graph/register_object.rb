require "graphql"
require "dry-initializer"
require "kanji/types"
require "kanji/type/attribute"
require "kanji/type/connection"
require "kanji/graph/coerce_type"

module Kanji
  class Graph
    class RegisterObject
      extend Dry::Initializer

      option :attributes, Types::Strict::Array.member(Type::Attribute)
      option :connections,
             Types::Strict::Array.member(Type::Connection), optional: true
      option :name, Types::Strict::String
      option :description, Types::Strict::String, optional: true

      def call
        name = self.name
        attributes = self.attributes
        connections = self.connections
        description = self.description
        coercer = Graph::CoerceType

        GraphQL::ObjectType.define do
          name name
          description description

          attributes.each do |attribute|
            field(
              attribute.name,
              coercer.(attribute.type),
              attribute.description
            )
          end

          connections.each do |connection|
            field(connection.name) do
              type -> { types[connection.type[:graphql_type]] }
              description connection.description
              resolve -> (obj, args, ctx) {
                connection.resolve.call(obj)
              }
            end
          end
        end
      end
    end
  end
end
