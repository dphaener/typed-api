require "dry-container"
require "kanji/types"
require "kanji/type/class_interface"
require "kanji/errors"

module Kanji
  class Type
    extend Dry::Container::Mixin
    extend ClassInterface

    include Dry::Container::Mixin

    def initialize(params)
      result = self.class.resolve(:schema).call(params)

      if result.success?
        register :value, -> { self.class.resolve(:value_object).new(params) }
      else
        errors = parse_error_messages(result)
        raise ValidationError, "Schema validation failed - #{errors}"
      end
    end

    private

    def parse_error_messages(result)
      result.messages(full: true).values.flatten.join(",")
    end
  end
end
