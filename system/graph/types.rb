require "dry/core/inflector"

require_relative "lib/helpers"

module Graph
  class Types
    include Graph::Helpers::Import["register_type", "coerce_type", "register_mutations"]

    def call(files, namespace)
      files.each do |type|
        require type

        type_name = Dry::Core::Inflector.singularize(File.basename(type, ".rb"))
        graphql_type = register_type.(type_name, coerce_type)

        ::Graph::Container.const_set("#{Dry::Core::Inflector.camelize(type_name)}Type", graphql_type)

        create, update, destroy = register_mutations.call(type_name, coerce_type)
        ::Graph::Container.const_set("Create#{Dry::Core::Inflector.camelize(type_name)}Mutation", create)
        ::Graph::Container.const_set("Update#{Dry::Core::Inflector.camelize(type_name)}Mutation", update)
        ::Graph::Container.const_set("Destroy#{Dry::Core::Inflector.camelize(type_name)}Mutation", destroy)
      end
    end
  end
end
