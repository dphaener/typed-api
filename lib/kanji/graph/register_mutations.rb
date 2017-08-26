require "graphql"
require "dry-initializer"
require "kanji/types"
require "dry/core/inflector"
require "kanji/graph/coerce_type"

module Kanji
  class Graph
    class RegisterMutations
      extend Dry::Initializer

      include Dry::Core::Inflector

      option :type
      option :attributes, Types::Strict::Array.member(Type::Attribute)

      def call
        [create_mutation, update_mutation, destroy_mutation]
      end

      private

      def create_mutation
        return_type = self.type
        attributes = self.attributes
        coercer = Graph::CoerceType.new

        GraphQL::Field.define do
          type -> { return_type }
          # TODO: fix this, because it won't work
          #name attributes.name
          #description attributes.description

          attributes.each do |attribute|
            next if attribute.name == :id
            argument(
              attribute.name,
              coercer.(attribute.type, attribute.options[:required]),
              attribute.description
            )
          end

          resolve lambda do |obj, args, context|
            attribute.resolve(obj)
          end
        end
      end

      def update_mutation
        return_type = self.type
        attributes = self.attributes
        coercer = Graph::CoerceType.new

        GraphQL::Field.define do
          type -> { return_klass }
          # TODO: fix this, because it won't work
          #name attributes.name
          #description attributes.description

          attributes.each do |attribute|
            argument(
              attribute.name,
              coercer.(attribute.type, attribute.options[:required]),
              attribute.description
            )
          end

          resolve lambda do |obj, args, context|
            attribute.resolve(obj)
          end
        end
      end

      def destroy_mutation(type_name, return_klass)
        return_type = self.type
        attributes = self.attributes
        coercer = Graph::CoerceType.new

        GraphQL::Field.define do
          type -> { return_klass }
          # TODO: fix this, because it won't work
          #name attributes.name
          #description attributes.description

          attributes.each do |attribute|
            argument(
              attribute.name,
              coercer.(attribute.type, attribute.options[:required]),
              attribute.description
            )
          end

          resolve lambda do |obj, args, context|
            attribute.resolve(obj)
          end
        end
      end
    end
  end
end
