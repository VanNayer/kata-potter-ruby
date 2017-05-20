require_relative '../basket'

describe Basket, '#price' do
  context 'with no book' do
    it('must return 0') { expect(Basket.price([])).to  eq(0) }
  end

  context 'with one book' do
    it('must return 8') { expect(Basket.price([3])).to eq(8) }
  end

  context 'with multiple books' do
    context 'but all the same' do
      it 'must not apply any discout' do
        expect(Basket.price([3, 3])).to eq(16)
        expect(Basket.price([2, 2, 2, 2])).to eq(32)
      end
    end

    context 'with basic discounts' do
      it('must apply 5% when two different books') { expect(Basket.price([1, 3])).to eq(8 * 2 * 0.95) }
      it('must apply 10% when three different books') { expect(Basket.price([1, 3, 2])).to eq(8 * 3 * 0.90) }
      it('must apply 20% when foor different books') { expect(Basket.price([2, 3, 4, 5])).to eq(8 * 4 * 0.80) }
      it('must apply 25% when five different books') { expect(Basket.price([1, 2, 3, 4, 5])).to eq(8 * 5 * 0.75) }
    end

    context 'with two sets' do
      it('must apply 10% on both sets') do
        expect(Basket.price([1, 1, 3, 3])).to eq(2 * (8 * 2 * 0.95))
      end
      it('must apply 20% on the first set and 10% on the second') do
        expect(Basket.price([0, 0, 1, 2, 2, 3])).to eq((8 * 4 * 0.8) + (8 * 2 * 0.95))
      end
    end
  end
end
