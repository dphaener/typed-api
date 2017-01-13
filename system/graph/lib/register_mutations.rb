require "graphql"
require "dry/core/inflector"

require_relative "../../import"
#require_relative "helpers"

module Graph
  class RegisterMutations
    include Import["persistence.db"]
    #include Graph::Helpers::Import["predicates"]

    def call(type_name, coercer)
      return_klass = Module.const_get("::Graph::Container::#{Dry::Core::Inflector.camelize(type_name)}Type")
      camel_klass = Dry::Core::Inflector.camelize(type_name)
      klass = Module.const_get("Relations::#{Dry::Core::Inflector.pluralize(camel_klass)}")

      create = create_mutation(type_name, klass, return_klass, coercer)
      update = update_mutation(type_name, klass, return_klass, coercer)
      destroy = destroy_mutation(type_name, klass, return_klass, coercer)

      [create, update, destroy]
    end

    def symbolize_keys(hsh)
      hsh.inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo}
    end

    def create_mutation(type_name, klass, return_klass, coercer)
      this = self

      GraphQL::Field.define do
        type -> { return_klass }

        # Register the attributes as GraphQL Arguments
        klass.schema.attributes.each do |field_name, type_def|
          next if field_name == :id
          argument(field_name, coercer.(type_def), type_name)
        end

        resolve -> (obj, args, context) {
          params = this.symbolize_keys(args.to_h)
          camel_klass = Dry::Core::Inflector.camelize(type_name)
          repo_klass = Module.const_get("Repositories::#{Dry::Core::Inflector.pluralize(camel_klass)}")
          repo = repo_klass.new(this.db)
          repo.create(**params)
        }
      end
    end

    def update_mutation(type_name, klass, return_klass, coercer)
      this = self

      GraphQL::Field.define do
        type -> { return_klass }

        # Register the attributes as GraphQL Arguments
        klass.schema.attributes.each do |field_name, type_def|
          argument(field_name, coercer.(type_def), type_name)
        end

        resolve -> (obj, args, context) {
          params = this.symbolize_keys(args.to_h)
          repo_klass = Module.const_get("Repositories::#{Dry::Core::Inflector.pluralize(type_name).capitalize}")
          repo = repo_klass.new(db_instance)
          repo.update(**params)
        }
      end
    end

    def destroy_mutation(type_name, klass, return_klass, coercer)
      db_instance = db

      GraphQL::Field.define do
        type -> { return_klass }

        argument :id, !types.ID

        resolve -> (obj, args, context) {
          repo_klass = Module.const_get("Repositories::#{Dry::Core::Inflector.pluralize(type_name).capitalize}")
          repo = repo_klass.new(db_instance)
          repo.destroy(args[:id])
        }
      end
    end
  end
end
