require "dry-struct"
require "kanji/types"

module Kanji
  class Type
    class Connection < Dry::Struct
      constructor_type :schema

      attribute :name, Kanji::Types::String
      attribute :type, Kanji::Types::Class
      attribute :description, Kanji::Types::String
      attribute :options, Kanji::Types::Hash
      attribute :resolve, Kanji::Types::Any
    end
  end
end
