require "graphql"

module Graph
  class RegisterType
    def call(type_name, coercer)
      klass = Module.const_get(type_name.capitalize)

      GraphQL::ObjectType.define do
        name "#{type_name.capitalize}Type"
        description klass.type_description rescue "A #{type_name.capitalize}"

        klass.schema.each do |field_name, type_def|
          field(field_name, coercer.(type_def), type_name)
        end
      end
    end
  end
end
