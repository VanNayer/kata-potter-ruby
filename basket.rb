require './tome_set'

class Basket
  BOOK_PRICE = 8
  DISCOUNTS = {0 => 0, 1 => 1, 2 => 0.95, 3 => 0.90, 4 => 0.80, 5 => 0.75}
  BEST_DISCOUNT = 4

  def self.price books
    tome_sets = books.group_by {|tome| tome }.map {|tome_id, tomes| TomeSet.new(tome_id, tomes.count)}
    compute_price(tome_sets)
  end

  def self.compute_price tome_sets
    return 0 if !tome_sets.any?

    if (tome_sets.select(&:many?).length < 4 && # after this iteration we CANNOT do another set of 5
      tome_sets.select(&:many?).length > 1 && # after this iteration we CAN do another set of multiple books
      tome_sets.select(&:any?).length >= 4) # and we CAN do set of 4 books

      4.times { |index| tome_sets[index].take_one! }
      compute_price_of_set(4) + compute_price(tome_sets.select(&:any?))
    else
      compute_price_of_set(tome_sets.length) + compute_price(tome_sets.each(&:take_one!).select(&:any?))
    end
  end

  def self.compute_price_of_set size
    size * BOOK_PRICE * DISCOUNTS[size]
  end
end
