# Class manage card in player hand.
class Hand
  attr_reader :cards, :points
  def initialize
    @cards = []
    @points = 0
  end

  def count_points
    self.points = 0
    cards.each do |card|
      self.points += card.points
    end
    # all_cards = []
    # self.aces = 0
    # self.points = 0
    # cards.each do |card|
    #   all_cards << card[0]
    # end
    # self.aces = all_cards.count('A')
    # all_cards.delete('A')

    # all_cards.each do |card|
    #   self.points += card_value(card)
    # end

    # count_aces_points if aces > 0
  end

  def show_cards
    self.cards.each do |card|
      [card.value, card.suit]
    end
  end

  def count_aces_points
    self.points += if aces == 1
                     if self.points + 11 > 21
                       1
                     else
                       11
                     end
                   elsif aces == 2
                     if self.points + 12 > 21
                       2
                     else
                       12
                     end
                   else
                     13
                   end
  end

  def zeroing_cards
    self.cards = []
  end

  private

  attr_writer :cards, :points, :aces

  
end
