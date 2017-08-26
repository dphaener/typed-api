require "dry-struct"
require "kanji/types"

module Kanji
  class Type
    class Attribute < Dry::Struct
      attribute :name, Kanji::Types::String
      attribute :type, Kanji::Types::Class
      attribute :description, Kanji::Types::String
      attribute :options, Kanji::Types::Hash
    end
  end
end
