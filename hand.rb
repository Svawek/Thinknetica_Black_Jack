# Class manage card in player hand.
class Hand
  attr_reader :cards, :points
  def initialize
    @cards = []
    @points = 0
  end

  def count_points
    self.points = 0
    aces = 0
    cards.each do |card|
      self.points += card.points
      aces += 1 if card.points == 11
    end

    if self.points > 21 && aces == 1
      self.points -= 10
    elsif self.points > 21 && aces == 2
      self.points = if self.points < 32
                      self.points - 10
                    else
                      self.points - 20
                    end
    elsif aces == 3
      self.points = 13
    end
  end

  def zeroing_cards
    self.cards = []
  end

  private

  attr_writer :cards, :points
end
