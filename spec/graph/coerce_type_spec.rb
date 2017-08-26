require "spec_helper"

describe Kanji::Graph::CoerceType do
  describe ".call" do
    context "when the type is required" do
      it "properly finds the type string" do
        result = Kanji::Graph::CoerceType.call(Kanji::Types::String)
        expect(result.to_s).to eq "String!"
      end
    end

    context "when the type is not required" do
      it "properly finds the type string" do
        result = Kanji::Graph::CoerceType.call(Kanji::Types::String.optional)
        expect(result.to_s).to eq "String"
      end
    end
  end
end
