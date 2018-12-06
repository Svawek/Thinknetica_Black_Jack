class Player
  attr_reader :cards, :balance, :points, :name
  def initialize(name)
    @cards = {}
    @balance = 100
    @points = 0
    @name = name
  end

  def change_balance(sum)
    self.balance += sum
  end

  def count_points
    aces = self.cards.select { |k,v| v == 11 }
    if aces.length > 1
      aces_arr = aces.to_a
      aces_arr.slice!(0)
      aces_arr.each do |card|
        self.cards[card[0]] = 1
      end
      self.cards.each_value do |value|
        self.points += value
      end
    else
      self.cards.each_value do |value|
        self.points += value
      end
    end
  end

  def zeroing_cards
    self.cards = {}
  end

  private
  attr_writer :cards, :balance, :points, :name
end
