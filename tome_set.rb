class TomeSet
  attr_reader :number_of_book, :id

  def initialize(id, number_of_book)
    @id = id
    @number_of_book = number_of_book
  end

  def take_one!
    @number_of_book -= 1
  end

  def any?
    @number_of_book.positive?
  end

  def many?
    @number_of_book > 1
  end

end
