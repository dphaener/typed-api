require_relative "../../../system/boot/api_type"

module User
  class Type < ApiType
    description "A user of this todo app"

    attribute :email, Types::Email
    attribute :first_name, Types::Strict::String
    attribute :last_name, Types::Strict::String
  end
end
