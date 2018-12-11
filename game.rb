# Class describe main game function
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
    card = deck.card_deck.pop
    player.hand[0].cards << card
    player.hand[0].count_points
  end

  def give_bank(player1, player2)
    points_p1 = player1.hand[0].points
    points_p2 = player2.hand[0].points
    if points_p1 == points_p2 || points_p1 > 21 && points_p2 > 21
      player1.change_balance(self.bank / 2)
      player2.change_balance(self.bank / 2)
    elsif points_p1 > points_p2 && points_p1 <= 21
      player1.change_balance(bank)
    else
      player2.change_balance(bank)
    end
    self.bank = 0
  end

  private

  attr_writer :bank
end
