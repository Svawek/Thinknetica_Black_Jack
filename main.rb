require_relative 'cards'
require_relative 'player'
require_relative 'game'

class Main
  attr_accessor :player1, :player2, :cards, :game
  def initialize
    @player1
    @player2
    @cards
    @game
  end

  def create_game
    puts greeting
    puts 'Введите Ваше имя:'
    name = gets.chomp
    self.player1 = Player.new(name)
    self.player2 = Player.new("Компьютер")
    self.cards = Cards.new
    self.game = Game.new
    deal
  end

  def deal
    self.cards.cards_interfere
    self.game.bet(self.player1, self.player2)
    2.times {self.game.give_card(player1, self.cards)}
    2.times {self.game.give_card(player2, self.cards)}
    print "Карты игрока #{player1.name}: #{show_cards(player1)}"
  end

  def player_selection

  end

  def show_cards(player)
    player.cards.each_key { |key| key }
  end

  def greeting
    'Приветствую в игре Black Jack Ruby'
  end

end

main = Main.new
main.create_game
