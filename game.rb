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

  def give_card(player, deck)
    player.cards << Hash[ [deck.card_deck.slice!(0)] ]
    player.count_points
  end

  def give_bank(player1, player2)
    if player1.points == player2.points
      player1.change_balance(self.bank/2)
      player2.change_balance(self.bank/2)
    elsif player1.points

    end
  end

  private
  attr_writer :bank
end
