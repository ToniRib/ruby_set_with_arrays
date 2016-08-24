require "simple_set"
require "pry"

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

        expect(set.elements).to match_array [1, 2]
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

  describe "#size" do
    it "returns 0 if the set is empty" do
      empty_set = SimpleSet.new

      expect(empty_set.size).to eq 0
    end

    it "returns the total number of elements" do
      set = SimpleSet.new([1])

      expect(set.size).to eq 1
    end
  end

  describe "#insert_multiple" do
    context "when the set is empty" do
      let(:empty_set) { SimpleSet.new }

      it "ignores nil elements" do
        empty_set.insert_multiple([nil, 1])

        expect(empty_set.elements).to eq [1]
      end

      it "adds the new elements" do
        new_elements = [1, 2]

        empty_set.insert_multiple(new_elements)

        expect(empty_set.elements).to match_array new_elements
      end

      it "ignores duplicate new elements" do
        new_elements = [1, 1]

        empty_set.insert_multiple(new_elements)

        expect(empty_set.elements).to eq [1]
      end
    end

    context "when the set does not contain the added elements" do
      let(:set) { SimpleSet.new([1]) }

      it "adds the new elements" do
        new_elements = [2, 3]

        set.insert_multiple([2, 3])

        expect(set.elements).to match_array [1, 2, 3]
      end
    end

    context "when the set contains the added elements" do
      let(:set) { SimpleSet.new([1]) }

      it "only adds the elements not already in the set" do
        set.insert_multiple([1, 2])

        expect(set.elements).to match_array [1, 2]
      end
    end
  end

  describe "#==" do
    it "returns true if the two sets are both empty" do
      empty_set = SimpleSet.new
      another_empty_set = SimpleSet.new

      equality = empty_set == another_empty_set

      expect(equality).to be true
    end

    it "returns false if the sets are of different sizes" do
      empty_set = SimpleSet.new
      single_element_set = SimpleSet.new([1])

      equality = empty_set == single_element_set

      expect(equality).to be false
    end

    it "returns false if the sets contain different elements" do
      set_with_element_one = SimpleSet.new([1])
      set_with_element_two = SimpleSet.new([2])

      equality = set_with_element_one == set_with_element_two

      expect(equality).to be false
    end

    it "returns true if the sets contain the same elements in the same order" do
      set_one = SimpleSet.new([1, 2])
      set_two = SimpleSet.new([1, 2])

      equality = set_one == set_two

      expect(equality).to be true
    end

    it "returns true if the sets contain the same elements in a different order" do
      set_one = SimpleSet.new([1, 2])
      set_two = SimpleSet.new([2, 1])

      equality = set_one == set_two

      expect(equality).to be true
    end
  end

  describe "#subset?" do
    it "returns true if both sets are empty" do
      empty_set = SimpleSet.new
      another_empty_set = SimpleSet.new

      expect(empty_set.subset?(another_empty_set)).to be true
    end

    it "returns true if an empty set is passed to a set with elements" do
      set = SimpleSet.new([1])
      empty_set = SimpleSet.new

      expect(empty_set.subset?(set)).to be true
    end

    it "returns false if a set with elements is passed to an empty set" do
      set = SimpleSet.new([1])
      empty_set = SimpleSet.new

      expect(set.subset?(empty_set)).to be false
    end

    it "returns false if the set contains different elements" do
      set = SimpleSet.new([1])
      other_set = SimpleSet.new([2, 3])

      expect(set.subset?(other_set)).to be false
    end

    it "returns true if the set contains all of the elements" do
      subset = SimpleSet.new([2, 1])
      set = SimpleSet.new([1, 2, 3])

      expect(subset.subset?(set)).to be true
    end
  end

  describe "#union" do
    it "returns a new set" do
      set = SimpleSet.new([1])
      other_set = SimpleSet.new([2])

      union_result = set.union(other_set)

      expect(union_result).to be_a SimpleSet
      expect(union_result).to_not be set
      expect(union_result).to_not be other_set
    end

    it "does not modify the original set" do
      set = SimpleSet.new([1])
      other_set = SimpleSet.new([2])

      set.union(other_set)

      expect(set.elements).to match_array [1]
    end

    it "does not modify the passed in set" do
      set = SimpleSet.new([1])
      other_set = SimpleSet.new([2])

      set.union(other_set)

      expect(other_set.elements).to match_array [2]
    end

    it "returns an empty set if both sets are empty" do
      first_empty_set = SimpleSet.new
      second_empty_set = SimpleSet.new

      union_result = first_empty_set.union(second_empty_set)

      expect(union_result).to be_empty
    end

    it "returns a new set with non-duplicate elements from both sets" do
      set = SimpleSet.new([1, 2])
      other_set = SimpleSet.new([2, 3])

      union_result = set.union(other_set)

      expect(union_result.elements).to match_array [1, 2, 3]
    end
  end
end
