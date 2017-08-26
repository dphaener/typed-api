class TestUserType < Kanji::Type
  name "TestUserType"
  description "A test user"

  attribute :email, Kanji::Types::String, "The test email", required: true
  attribute :name do
    type Kanji::Types::String.optional
    description "The test name"
  end

  has_many :posts do
    type TestPostType
    description "The test posts for this user"

    resolve ->(user) { user.posts }
  end
end
