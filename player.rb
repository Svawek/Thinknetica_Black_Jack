# Class manage main players functions
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
    points_arr = []
    last_card_value = cards.to_a.last[1]

    aces = cards.select { |_k, v| v == 11 }
    aces_arr = aces.to_a
    if aces.length > 1
      aces_arr.slice!(0)
      aces_arr.each do |card|
        cards[card[0]] = 1
      end
    elsif cards.length == 3 && (points + last_card_value > 21 && !aces.empty?)
      aces_arr.each do |card|
        cards[card[0]] = 1
      end
    end

    @points = 0
    cards.each_value do |value|
      points_arr << value
    end
    points_arr.each { |point| self.points += point }
  end

  def zeroing_cards
    self.cards = {}
  end

  private

  attr_writer :cards, :balance, :points, :name
end
