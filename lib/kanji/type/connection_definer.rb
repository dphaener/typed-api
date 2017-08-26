require "kanji/type/connection"
require "kanji/instance_define"
require "kanji/errors"

module Kanji
  class Type
    class ConnectionDefiner
      extend Kanji::InstanceDefine

      instance_define :type, :description, :resolve

      def initialize(name, type = nil, description = nil, **kwargs, &block)
        @_name = name
        @_type = type
        @_description = description
        self.instance_eval &block if block_given?

        raise AttributeError unless @_type && @_resolve
      end

      def call
        Connection.new({
          name: @_name,
          type: @_type,
          description: @_description,
          resolve: @_resolve
        })
      end
    end
  end
end
