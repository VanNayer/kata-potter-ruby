class Basket
  DISCOUNTS = {0 => 0, 1 => 1, 2 => 0.95, 3 => 0.90, 4 => 0.80, 5 => 0.75}
  BOOK_PRICE = 8

  def self.price books
    nb_of_book_by_tome = books.group_by {|tome| tome }.map {|tome_id, tomes| [tome_id, tomes.count]}
    compute_price(nb_of_book_by_tome)
  end

  def self.compute_price nb_of_book_by_tome
    if nb_of_book_by_tome.any?
      compute_price_of_set(nb_of_book_by_tome.length) +
        compute_price(nb_of_book_by_tome.map {|tome| [tome[0], tome[1] - 1]}.select { |x| x[1].positive? })
    else
      0
    end
  end

  def self.compute_price_of_set size
    size * 8 * DISCOUNTS[size]
  end
end
