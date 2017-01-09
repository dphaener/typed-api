require_relative "lib/helpers"

module Graph
  class Types
    include Graph::Helpers::Import["register_type", "coerce_type"]

    def call(files, namespace)
      files.each do |type|
        require type

        dirname = File.dirname(type).split("/").last
        type_name = dirname.capitalize
        graphql_type = register_type.(type_name, coerce_type)

        ::Graph::Container.const_set("#{type_name.capitalize}Type", graphql_type)
      end
    end
  end
end
