# Describe creation of deck
class Deck
  CARDS = %w[2 3 4 5 6 7 8 9 10 V Q K A].freeze
  SUITS = %w[♤ ♡ ♧ ♢].freeze

  attr_reader :cards

  def initialize
    @cards = []
  end

  def cards_interfere
    CARDS.each do |card|
      SUITS.each do |suit|
        self.cards << Card.new(card, suit)
      end
    end
    self.cards = self.cards.shuffle.take(6)
  end

  private

  attr_writer :cards
end
