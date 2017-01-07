require "dry-container"

require_relative "schema"
require_relative "type"
require_relative "../../../system/import"

module User
  class Resolve
    include Dry::Container::Mixin
    include Import["persistence.db"]

    register :all do |object, inputs, context|
      db.
    end
  end
end
