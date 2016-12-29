require_relative "../system/boot/api_type"

class User < ApiType
  description "A user of this todo app"

  attribute :email, Types::Email
  attribute :first_name, Types::Strict::String
  attribute :last_name, Types::Strict::String
end
