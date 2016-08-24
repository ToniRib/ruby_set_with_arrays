class SimpleSet
  attr_reader :elements

  def initialize(elements = [])
    @elements = elements.uniq
  end

  def contains?(element)
    elements.include?(element)
  end

  def empty?
    elements.empty?
  end

  def size
    elements.size
  end

  def insert(element)
    @elements << element unless element_should_not_be_added(element)
  end

  def insert_multiple(new_elements)
    @elements.concat(new_elements.uniq.compact).uniq!
  end

  def ==(other)
    check_argument(other)

    equal_size(other) && sorted_elements_match(other)
  end

  def subset?(other)
    check_argument(other)

    same_size_or_smaller(other) && contains_all_elements(other)
  end

  def union(other)
    check_argument(other)

    new((elements + other.elements).uniq)
  end

  def intersection(other)
    check_argument(other)

    new(elements & other.elements)
  end

  def difference(other)
    check_argument(other)

    new(elements - other.elements)
  end

  private

  def check_argument(other)
    raise_non_set_argument_error unless argument_is_a_simple_set(other)
  end

  def raise_non_set_argument_error
    raise ArgumentError, "Argument must be a SimpleSet"
  end

  def argument_is_a_simple_set(other)
    other.class == self.class
  end

  def equal_size(set)
    size == set.size
  end

  def sorted_elements_match(set)
    elements.sort == set.elements.sort
  end

  def same_size_or_smaller(set)
    size <= set.size
  end

  def element_should_not_be_added(element)
    element.nil? || contains?(element)
  end

  def contains_all_elements(set)
    elements.all? { |element| set.contains?(element) }
  end

  def new(elements)
    self.class.new(elements)
  end
end
