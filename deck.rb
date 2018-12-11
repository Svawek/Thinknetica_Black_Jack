# Describe creation of deck
class Deck
  CARDS = %w[2 3 4 5 6 7 8 9 10 V Q K A].freeze
  SUITS = %w[♤ ♡ ♧ ♢].freeze

  attr_reader :card_deck

  def initialize
    @card_deck = []
  end

  def cards_interfere
    deck = []
    CARDS.each do |card|
      SUITS.each do |suit|
        deck << [card, suit]
      end
    end
    deck = deck.shuffle.take(6)
    deck.each do |card|
      create_card(card[0], card[1])
    end
  end

  def create_card(value, suit)
    self.card_deck << Card.new(value, suit)
  end

  private

  attr_writer :card_deck
end
