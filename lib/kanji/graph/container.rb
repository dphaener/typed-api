require "dry-container"
require "kanji/graph/register_object"

module Kanji
  class Graph
    class Container
      extend Dry::Container::Mixin

      namespace :graphql do
        register :register_object, ->(params) { RegisterObject.new(params) }
      end
    end
  end
end
