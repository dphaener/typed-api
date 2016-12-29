require "dry-validation"
require_relative "predicates"

UserSchema = Dry::Validation.Schema do
  configure do
    predicates(Predicates)
  end

  required(:email) { filled? & email? }
  required(:first_name) { filled? & str? }
  required(:last_name) { filled? > str? }
end
