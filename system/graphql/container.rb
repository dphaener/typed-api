require "dry-container"

require_relative "lib/coerce_type"
require_relative "lib/register_type"

class GraphContainer
  extend Dry::Container::Mixin

  register("coerce") { CoerceType.new }
  register("register_type") { RegisterType.new }

  namespace("types") do
    types = Dir["./types/*.rb"]

    types.each do |type|
      require type

      type_name = File.basename(type, File.extname(type))

      register(type_name) do
        resolve("register_type").(type_name, resolve("coerce"))
      end
    end
  end
end
