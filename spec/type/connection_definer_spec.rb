require "spec_helper"

describe Kanji::Type::ConnectionDefiner do
  describe "extended modules" do
    subject { Kanji::Type::ConnectionDefiner }

    it { is_expected.to extend_module Kanji::InstanceDefine }
  end

  describe "defined instance methods" do
    subject do
      Kanji::Type::ConnectionDefiner.new(:foo, Kanji::Types::String) do
        resolve ->(foo) { foo }
      end
    end

    it { is_expected.to define_instance_method :type }
    it { is_expected.to define_instance_method :description }
    it { is_expected.to define_instance_method :resolve }
  end

  describe "#initialize" do
    context "when type is given" do
      context "and block with type definition is given" do
        subject do
          Kanji::Type::ConnectionDefiner.new(:foo, Kanji::Types::String) do
            type Kanji::Types::Bool
            resolve ->(foo) { foo }
          end.call
        end

        it "overwrites the given type" do
          expect(subject.type).to eql Kanji::Types::Bool
        end
      end

      context "and block with no type definition is given" do
        subject do
          Kanji::Type::ConnectionDefiner.new(:foo, Kanji::Types::String) do
            description "Bar"
            resolve ->(foo) { foo }
          end.call
        end

        it "does not overwrite the given type" do
          expect(subject.type).to eql Kanji::Types::String
        end
      end
    end

    context "when type is not given" do
      context "and block with type definition is given" do
        subject do
          Kanji::Type::ConnectionDefiner.new(:foo) do
            type Kanji::Types::String
            resolve ->(foo) { foo }
          end.call
        end

        it "sets the type from the block" do
          expect(subject.type).to eql Kanji::Types::String
        end
      end

      context "and block with no type definition is given" do
        subject do
          Kanji::Type::ConnectionDefiner.new(:foo) do
            description "Foo bar"
            resolve ->(foo) { foo }
          end
        end

        it "raises an exception" do
          expect { subject.call }.
            to raise_exception(Kanji::AttributeError)
        end
      end
    end

    context "when description is given" do
      context "and block with description is given" do
        subject do
          Kanji::Type::ConnectionDefiner.new(:foo, Kanji::Types::String, "Foo") do
            description "Bar"
            resolve ->(foo) { foo }
          end.call
        end

        it "overwrites the given description" do
          expect(subject.description).to eql "Bar"
        end
      end

      context "and block with no description is given" do
        subject do
          Kanji::Type::ConnectionDefiner.new(:foo, Kanji::Types::String, "Foo") do
            resolve ->(foo) { foo }
          end.call
        end

        it "does not overwrite the given description" do
          expect(subject.description).to eql "Foo"
        end
      end
    end

    context "when description is not given" do
      context "and block with description is given" do
        subject do
          Kanji::Type::ConnectionDefiner.new(:foo, Kanji::Types::String) do
            description "Bar"
            resolve ->(foo) { foo }
          end.call
        end

        it "sets the description" do
          expect(subject.description).to eql "Bar"
        end
      end

      context "and block with no description is given" do
        subject do
          Kanji::Type::ConnectionDefiner.new(:foo) do
            type Kanji::Types::String
            resolve ->(foo) { foo }
          end.call
        end

        it "does not set the description" do
          expect(subject.description).to be nil
        end
      end
    end

    context "when resolve is given" do
      subject do
        Kanji::Type::ConnectionDefiner.new(:foo) do
          type Kanji::Types::String
          resolve "Foo"
        end.call
      end

      it "sets the resolve" do
        expect(subject.resolve).to eql "Foo"
      end
    end

    context "when resolve is not given" do
      subject do
        Kanji::Type::ConnectionDefiner.new(:foo) do
          type Kanji::Types::String
        end
      end

      it "raises and exception" do
        expect { subject.call }.
          to raise_exception(Kanji::AttributeError)
      end
    end
  end

  describe "#call" do
    subject do
      Kanji::Type::ConnectionDefiner.new(:foo) do
        type Kanji::Types::String
        description "Foo"
        resolve "Bar"
      end
    end

    it "creates a new attribute" do
      expected = Kanji::Type::Connection.new({
        name: :foo,
        type: Kanji::Types::String,
        description: "Foo",
        resolve: "Bar"
      })

      expect(subject.call).to eql expected
    end
  end
end
