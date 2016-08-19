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

  def ==(other_set)
    size == other_set.size && elements.sort == other_set.elements.sort
  end

  def subset?(other_set)
    size <= other_set.size && other_set_contains_all_elements(other_set)
  end

  private

  def element_is_nil_or_already_in_set(element)
    element.nil? || contains?(element)
  end

  def other_set_contains_all_elements(set)
    elements.all? { |element| set.contains?(element) }
  end
end
