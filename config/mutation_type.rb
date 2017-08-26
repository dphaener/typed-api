require "graphql"

class MutationType
  def call
    GraphQL::ObjectType.define do
      name "MutationType"
      description "The mutation root of this schema"

      # Put your mutation fields here
    end
  end
end
