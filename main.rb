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
    @show = false
    @skip_turn = true
    @more_cards = true
    @open_cards = true
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
    self.game.bet(player1, player2)
    #2.times do
    for i in 1..2
      self.game.give_card(player1, self.cards)
      self.game.give_card(player2, self.cards)
    end
    print "Карты игрока #{player1.name}: #{show_cards(player1)}"
    cards_amount = player2.cards.length
    if @show
      puts "Карты игрока #{player2.name}: #{show_cards(player2)}"
    else
      puts "Карты игрока #{player2.name}: #{cards_amount.times { print "*" }}"
    end
    player_selection
  end

  def player_selection
    puts ""
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
