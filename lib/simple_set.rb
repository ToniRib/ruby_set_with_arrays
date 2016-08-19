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
    @elements << element unless element_is_nil_or_already_in_set(element)
  end

  def insert_multiple(new_elements)
    @elements.concat(new_elements.uniq.compact).uniq!
  end

  def ==(other)
    equal_size(other) && sorted_elements_match(other)
  end

  def subset?(other_set)
    same_size_or_smaller(other_set) && contains_all_elements(other_set)
  end

  private

  def equal_size(set)
    size == set.size
  end

  def sorted_elements_match(set)
    elements.sort == set.elements.sort
  end

  def same_size_or_smaller(set)
    size <= set.size
  end

  def element_is_nil_or_already_in_set(element)
    element.nil? || contains?(element)
  end

  def contains_all_elements(set)
    elements.all? { |element| set.contains?(element) }
  end
end
