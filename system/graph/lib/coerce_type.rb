require "graphql"

module Graph
  class CoerceType
    TYPE_MAP = {
      "String" => "String",
      "Integer" => "Int",
      "Float" => "Float",
      "FalseClass" => "Boolean",
      "TrueClass | FalseClass" => "Boolean",
      "FalseClass | TrueClass" => "Boolean"
    }

    def call(type)
      type_string = TYPE_MAP[type.name]

      if type.constrained?
        !GraphQL::Define::TypeDefiner.instance.send(type_string)
      else
        GraphQL::Define::TypeDefiner.instance.send(type_string)
      end
    end
  end
end
