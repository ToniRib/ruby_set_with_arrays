require "simple_set"

RSpec.describe SimpleSet do
  describe ".new" do
    let(:non_repeated_elements) { [1, 2] }
    let(:repeated_elements) { [1, 1] }

    it "initializes with no elements if none are passed in" do
      empty_set = SimpleSet.new

      expect(empty_set.elements).to eq Array.new
    end

    it "can be initialized with an array of non-repeated elements" do
      set = SimpleSet.new(non_repeated_elements)

      expect(set.elements).to include *non_repeated_elements
    end

    it "removes repeated elements when initialized" do
      set = SimpleSet.new(repeated_elements)

      expect(set.elements).to eq [1]
    end
  end

  describe "#contains?" do
    let(:element) { 2 }

    it "returns false when queried on an empty set" do
      empty_set = SimpleSet.new

      response = empty_set.contains?(element)

      expect(response).to be false
    end

    it "returns false if the element is not in the set" do
      single_element_set = SimpleSet.new([5])

      response = single_element_set.contains?(element)

      expect(response).to be false
    end

    it "returns true if the element is in the set" do
      single_element_set = SimpleSet.new([element])

      response = single_element_set.contains?(element)

      expect(response).to be true
    end
  end

  describe "#insert" do
    context "when the set is empty" do
      let(:empty_set) { SimpleSet.new }

      it "remains empty when nil is added" do
        empty_set.insert(nil)

        expect(empty_set.elements).to eq Array.new
      end

      it "adds the new element" do
        empty_set.insert(1)

        expect(empty_set.elements).to eq [1]
      end
    end

    context "when the set does not contain the added element" do
      let(:set) { SimpleSet.new([1]) }

      it "adds the new element" do
        set.insert(2)

        expect(set.elements).to include *[1, 2]
      end
    end

    context "when the set contains the added element" do
      let(:set) { SimpleSet.new([1]) }

      it "does not add the new element" do
        set.insert(1)

        expect(set.elements).to eq [1]
      end
    end
  end

  describe "#empty?" do
    it "returns true if the set has no elements" do
      empty_set = SimpleSet.new

      expect(empty_set.empty?).to be true
    end

    it "returns false if the set has one or more elements" do
      set = SimpleSet.new([1])

      expect(set.empty?).to be false
    end
  end
end
