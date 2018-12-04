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

  private
  attr_writer :cards, :balance, :points, :name
end
