require "graphql"
require "dry/core/inflector"

require_relative "../../import"

module Graph
  class RegisterType
    include Import["persistence.db"]

    def call(type_name, coercer)
      singular_type = Dry::Core::Inflector.singularize(type_name)
      plural_type = Dry::Core::Inflector.pluralize(type_name)
      klass = Module.const_get("Relations::#{plural_type.capitalize}")
      db_instance = db

      GraphQL::ObjectType.define do
        name "#{type_name.capitalize}Type"
        description klass.type_description rescue "A #{type_name.capitalize}"

        # Register the attributes as GraphQL Fields
        klass.schema.attributes.each do |field_name, type_def|
          field(field_name, coercer.(type_def), type_name)
        end

        # Register the associations as GraphQL Fields
        klass.schema.associations.elements.each do |target, assoc|
          target_klass = Module.const_get("::Graph::Container::#{Dry::Core::Inflector.singularize(target).capitalize}Type")

          if assoc.result == :many
            field(target) do
              type -> { types[target_klass] }
              resolve -> (obj, args, ctx) {
                repo_klass = Module.const_get("Repositories::#{Dry::Core::Inflector.pluralize(target).capitalize}")
                repo = repo_klass.new(db_instance)
                repo.public_send("for_#{singular_type}".to_sym, obj.id)
              }
            end
          else
            field(target, target_klass, target.to_s)
          end
        end
      end
    end
  end
end
