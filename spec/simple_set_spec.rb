require "simple_set"

RSpec.describe SimpleSet do
  describe "#contains?" do
    let(:element) { 2 }

    it "returns false when queried on an empty set" do
      empty_set = Set.new

      response = empty_set.contains?(element)

      expect(response).to be false
    end
  end
end
