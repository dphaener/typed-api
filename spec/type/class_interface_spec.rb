require "spec_helper"

describe Kanji::Type::ClassInterface do
  describe "attributes" do
    context "TestUserType" do
      it "sets the name attribute" do
        expect(TestUserType._name).to eql "TestUserType"
      end

      it "sets the description attribute" do
        expect(TestUserType._description).to eql "A test user"
      end
    end

    context "TestPostType" do
      it "sets the name attribute" do
        expect(TestPostType._name).to eql "TestPostType"
      end

      it "sets the description attribute" do
        expect(TestPostType._description).to eql "A test post"
      end
    end
  end

  describe "class macros" do
    describe ".attribute" do
      context "TestUserType" do
        it "pushes the attribute into an array" do
          expected = [
            Kanji::Type::Attribute.new({
              name: :email,
              type: Kanji::Types::String,
              description: "The test email",
              options: { required: true }
            }),
            Kanji::Type::Attribute.new({
              name: :name,
              type: Kanji::Types::String.optional,
              description: "The test name",
              options: {}
            })
          ]

          expect(TestUserType._attributes).to eql expected
        end
      end

      context "TestPostType" do
        it "pushes the attribute into an array" do
          expected = [
            Kanji::Type::Attribute.new({
              name: :title,
              type: Kanji::Types::String,
              description: "A test title",
              options: { required: true }
            }),
            Kanji::Type::Attribute.new({
              name: :body,
              type: Kanji::Types::String,
              description: "A test body",
              options: { required: true }
            })
          ]

          expect(TestPostType._attributes).to eql expected
        end
      end

      it "doesn't allow duplicate attribute names" do
        expect do
          TestUserType.attribute(:email, Kanji::Types::String, "Test")
        end.to raise_exception(
          Kanji::AttributeError,
          "Attribute email is already defined"
        )
      end
    end

    describe ".has_many" do
      it "doesn't allow duplicate connections" do
        expect do
          TestUserType.has_many(:posts)
        end.to raise_exception(
          Kanji::AttributeError,
          "Connection posts is already defined"
        )
      end

      it "adds connections to the class" do
        posts = TestUserType._connections[0]
        user = OpenStruct.new(posts: ["foo"])

        expect(posts.name).to eql :posts
        expect(posts.type).to eql TestPostType
        expect(posts.description).to eql "The test posts for this user"
        expect(posts.options).to be nil
        expect(posts.resolve.class).to be Proc
        expect(posts.resolve.call(user)).to match_array ["foo"]
      end
    end
  end

  describe "container registry" do
    describe "schema" do
      subject { TestUserType[:schema] }

      it "registers the schema" do
        expect(subject.type_map.keys).to match_array [:name, :email, :posts]
      end

      it "registers optional attributes as optional" do
        expect(subject.type_map[:name].optional?).to be true
      end

      it "registers the other schema" do
        expect(TestPostType[:schema].type_map.keys).to eq [:title, :body]
      end
    end

    describe "graphql_type" do
      context "TestUserType" do
        subject { TestUserType[:graphql_type] }

        it { is_expected.to have_field(:email).of_type("String!") }
        it { is_expected.to have_field(:name).of_type("String") }
        it { is_expected.to have_field(:posts).of_type("[TestPostType]") }
      end

      context "TestPostType" do
        subject { TestPostType[:graphql_type] }

        it { is_expected.to have_field(:title).of_type("String!") }
        it { is_expected.to have_field(:body).of_type("String!") }
      end
    end

    describe "value_object" do
      context "TestUserType" do
        it "creates a new value object" do
          object = TestUserType[:value_object]
          expect(object.inspect).to eql "TestUserTypeValue"
          expect(object.schema.keys).to match_array [:name, :email]
        end
      end

      context "TestPostType" do
        it "creates a new value object" do
          object = TestPostType[:value_object]
          expect(object.inspect).to eql "TestPostTypeValue"
          expect(object.schema.keys).to match_array [:title, :body]
        end
      end
    end
  end
end
