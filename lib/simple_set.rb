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

  def insert(element)
    @elements << element unless element.nil? || contains?(element)
  end
end
