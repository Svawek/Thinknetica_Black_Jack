class Game
  attr_reader :bank
  def initialize
    @bank = 0
  end

  def bet(player1, player2)
    player1.change_balance(-10)
    player2.change_balance(-10)
    self.bank += 20
  end

  private
  attr_writer :bank
end
