require "dry-struct"

require_relative "types"

class ApiType < Dry::Struct::Value
  constructor_type :strict_with_defaults

  class << self
    attr_accessor :type_description

    def description(descriptor)
      @type_description = descriptor
    end
  end
end
