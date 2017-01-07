require_relative "lib/helpers"

module Graph
  class Types
    include Graph::Helpers::Import["register_type", "coerce_type"]

    def call(files)
      files.each do |type|
        require type

        type_name = File.basename(type, File.extname(type))
        graphql_type = register_type.(type_name, coerce_type)

        Graph::Types.const_set("#{type_name.capitalize}Type", graphql_type)
      end
    end
  end
end
