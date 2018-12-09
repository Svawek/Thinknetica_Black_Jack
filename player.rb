# Class manage main players functions
class Player
  attr_reader :balance, :name, :hand
  def initialize(name)
    @balance = 100
    @name = name
    @hand = []
  end

  def change_balance(sum)
    self.balance += sum
  end

  private
  attr_writer :balance, :name, :hand
end
