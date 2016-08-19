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

  private

  def element_is_nil_or_already_in_set(element)
    element.nil? || contains?(element)
  end
end
