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

        ::Graph::Container.const_set("#{type_name.capitalize}Type", graphql_type)

        create, update, destroy = register_mutations.call(type_name, coerce_type)
        ::Graph::Container.const_set("Create#{type_name.capitalize}Mutation", create)
        ::Graph::Container.const_set("Update#{type_name.capitalize}Mutation", update)
        ::Graph::Container.const_set("Destroy#{type_name.capitalize}Mutation", destroy)
      end
    end
  end
end
