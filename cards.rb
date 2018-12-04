class Cards
  CARDS_VALUE = {
    "2\u2665" => 2, "2\u2666" => 2, "2\u2663" => 2, "2\u2660" => 2,
    "3\u2665" => 3, "3\u2666" => 3, "3\u2663" => 3, "3\u2660" => 3,
    "4\u2665" => 4, "4\u2666" => 4, "4\u2663" => 4, "4\u2660" => 4,
    "5\u2665" => 5, "5\u2666" => 5, "5\u2663" => 5, "5\u2660" => 5,
    "6\u2665" => 6, "6\u2666" => 6, "6\u2663" => 6, "6\u2660" => 6,
    "7\u2665" => 7, "7\u2666" => 7, "7\u2663" => 7, "7\u2660" => 7,
    "8\u2665" => 8, "8\u2666" => 8, "8\u2663" => 8, "8\u2660" => 8,
    "9\u2665" => 9, "9\u2666" => 9, "9\u2663" => 9, "9\u2660" => 9,
    "10\u2665" => 10, "10\u2666" => 10, "10\u2663" => 10, "10\u2660" => 10,
    "V\u2665" => 10, "V\u2666" => 10, "V\u2663" => 10, "V\u2660" => 10,
    "Q\u2665" => 10, "Q\u2666" => 10, "Q\u2663" => 10, "Q\u2660" => 10,
    "K\u2665" => 10, "K\u2666" => 10, "K\u2663" => 10, "K\u2660" => 10,
    "T\u2665" => 11, "T\u2666" => 11, "T\u2663" => 11, "T\u2660" => 11
  }
  attr_reader :card_deck

  def initialize
    @card_deck = {}
  end

  def cards_interfere
    new_deck = CARDS_VALUE.to_a.shuffle
    self.card_deck = new_deck.take(6).to_h
  end

  private
  attr_writer :card_deck
end
