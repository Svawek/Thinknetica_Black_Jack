# Class manage card in player hand.
class Hand
  attr_reader :cards, :points
  def initialize
    @cards = []
    @points = 0
  end

  def count_points
    sum = self.cards.map(&:points).sum
    self.cards.select(&:ace?).each { sum -= 10 if sum > 21 }
    self.points = sum
  end

  def zeroing_cards
    self.cards = []
  end

  private

  attr_writer :cards, :points
end
