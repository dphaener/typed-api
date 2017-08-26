require "graphql"

module Kanji
  class Graph
    class CoerceType
      def self.call(type)
        type_string = TYPE_MAP[get_primitive_type(type)]

        if type.optional?
          GraphQL::Define::TypeDefiner.instance.send(type_string)
        else
          !GraphQL::Define::TypeDefiner.instance.send(type_string)
        end
      end

      private

      TYPE_MAP = {
        "String" => "String",
        "Integer" => "Int",
        "Float" => "Float",
        "FalseClass" => "Boolean",
        "TrueClass | FalseClass" => "Boolean",
        "FalseClass | TrueClass" => "Boolean"
      }

      def self.get_primitive_type(type)
        type.optional? ?
          type.right.primitive.to_s :
          type.primitive.to_s
      end
    end
  end
end
