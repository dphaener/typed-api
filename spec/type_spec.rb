require "spec_helper"

describe Kanji::Type do
  describe "initialize" do
    subject(:test) { TestUserType.new(input) }

    let(:posts) do
      [ { title: "Foo", body: "Bar" }, { title: "Baz", body: "Bon" } ]
    end

    let(:input) do
      {
        name: "Darin",
        email: "dph@foo.com",
        posts: posts
      }
    end

    context "with valid input" do
      it "creates a new value object" do
        value = test[:value]
        expect(value.name).to eql "Darin"
        expect(value.email).to eql "dph@foo.com"
        expect(value.class.name).to eql "TestUserTypeValue"
      end
    end

    context "with invalid input" do
      let(:input) do
        { name: "Darin" }
      end

      it "raises a ValidationError" do
        expect { test }.
          to raise_exception(Kanji::ValidationError)
      end
    end
  end
end
