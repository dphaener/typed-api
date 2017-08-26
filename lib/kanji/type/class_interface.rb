require "dry-validation"
require "graphql"
require "dry/core/class_builder"
require "dry/core/constants"
require "dry/core/inflector"
require "kanji/type/attribute"
require "kanji/type/connection"
require "kanji/graph/register_object"
require "kanji/type/connection_definer"
require "kanji/type/attribute_definer"

module Kanji
  class Type
    module ClassInterface
      include Dry::Core::Constants
      include Dry::Core::Inflector

      attr_reader :_attributes, :_name, :_description, :_connections

      def register_graphql_type(klass)
        klass.register :graphql_type do
          Kanji::Graph::RegisterObject.new(
            attributes: klass._attributes,
            connections: klass._connections,
            name: klass._name,
            description: klass._description
          ).call
        end
      end

      def inherited(klass)
        super

        klass.instance_variable_set(:@_attributes, [])
        klass.instance_variable_set(:@_connections, [])

        TracePoint.trace(:end) do |t|
          if klass == t.self
            self.finalize(klass)
            t.disable
          end
        end
      end

      def finalize(klass)
        register_graphql_type(klass)
        klass.register :schema, -> { klass.register_schema }
        klass.register :value_object, -> { klass.create_value_object }
      end

      def name(name)
        @_name = name
      end

      def description(description)
        @_description = description
      end

      def attribute(name, type = nil, description = nil, **kwargs, &block)
        if @_attributes.map(&:name).include?(name)
          fail AttributeError, "Attribute #{name} is already defined"
        else
          @_attributes <<
            AttributeDefiner.new(name, type, description, kwargs, &block).call
        end
      end

      def has_many(name, type = nil, description = nil, **kwargs, &block)
        if @_connections.map(&:name).include?(name)
          fail AttributeError, "Connection #{name} is already defined"
        else
          definer = ConnectionDefiner.new(name, type, description, &block)
          @_connections << definer.call
        end
      end

      def register_schema
        attributes = _attributes
        connections = _connections

        Dry::Validation.JSON do
          configure { config.type_specs = true }

          attributes.each do |attribute|
            if attribute.options[:required]
              required(attribute.name, attribute.type).filled
            else
              optional(attribute.name, attribute.type).maybe
            end
          end

          connections.each do |connection|
            optional(connection.name).each do
              schema do
                connection.type._attributes.each do |attribute|
                  if attribute.options[:required]
                    required(attribute.name, attribute.type).filled
                  else
                    optional(attribute.name, attribute.type).maybe
                  end
                end
              end
            end
          end
        end
      end

      def create_value_object
        builder = Dry::Core::ClassBuilder.new(
          name: "#{instance_variable_get(:@_name)}Value",
          parent: Dry::Struct::Value
        )
        klass = builder.call

        instance_variable_get(:@_attributes).each do |attribute|
          klass.attribute(attribute.name, attribute.type)
        end

        klass
      end
    end
  end
end

