# Class manage cards and their values
class Cards
  CARDS = %w[2 3 4 5 6 7 8 9 10 V Q K A].freeze
  SUITS = %w[♤ ♡ ♧ ♢].freeze
  attr_reader :card_deck

  def initialize
    @card_deck = []
  end

  def cards_interfere
    cards = (CARDS * 4).shuffle.take(6)
    cards.each do |v|
      card = create_card(v)
      card = create_card(v) while card_deck.include?(card)
      card_deck << card
    end
  end

  private

  attr_writer :card_deck

  def create_card(card)
    [card, SUITS.sample]
  end
end
