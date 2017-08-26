class TestPostType < Kanji::Type
  name "TestPostType"
  description "A test post"

  attribute :title, Kanji::Types::String, "A test title", required: true
  attribute :body, Kanji::Types::String, "A test body", required: true

  #belongs_to :user, TestUserType
end
