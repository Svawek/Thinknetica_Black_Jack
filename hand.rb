# Class manage card in player hand.
class Hand
  attr_reader :cards, :points, :aces
  def initialize
    @cards = []
    @points = 0
    @aces = 0
  end

  def count_points
    all_cards = []
    self.aces = 0
    self.points = 0
    self.cards.each do |card|
      all_cards << card[0]
    end
    self.aces = all_cards.count("A")
    all_cards.delete("A")

    all_cards.each do |card|
      self.points += card_value(card)
    end

    count_aces_points if self.aces > 0
  end

  def count_aces_points
    if self.aces == 1
      if self.points + 11 > 21
        self.points += 1
      else
        self.points += 11
      end
    elsif self.aces == 2
      if self.points + 12 > 21
        self.points += 2
      else
        self.points += 12
      end
    else
      self.points += 13
    end
  end

  def zeroing_cards
    self.cards = []
  end

  private
  attr_writer :cards, :points, :aces
 
  def card_value(card)
    if card[0].to_i > 0
      card[0].to_i
    elsif card[0] == "10"
      10
    else
      10
    end
  end
end
