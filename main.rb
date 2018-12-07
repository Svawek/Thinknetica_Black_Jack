require_relative 'cards'
require_relative 'player'
require_relative 'game'
require 'byebug'

class Main
  attr_accessor :player1, :player2, :cards, :game, :cards_picture
  def initialize
    @player1
    @player2
    @cards
    @game
    @show = false
    @skip_turn = true
    @more_cards_player1 = true
    @more_cards_player2 = true
    @open_cards = true
    @cards_picture = []
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
    player1.count_points
    player2.count_points
    show_points
    player_selection
  end

  def player_selection
    puts "Нажмите M, что бы взять еще одну карту" if @more_cards_player1
    puts "Нажмите S, что бы пропустить ход" if @skip_turn
    puts "Нажмите O, что бы открыть карты" if @open_cards
    answer = gets.chomp
    case answer
    when "M", "m"
      one_more_card(player1)
    when "S", "s"
      skip_player_turn(player1)
    when "O", "o"
      open_all_cards
    else
      puts "Не правильный выбор"
    end
  end

  def one_more_card(player)
    self.game.give_card(player, self.cards)
    player.count_points
    if player == player1
      @more_cards_player1 = false
      show_points
      player2_turn
    elsif player1.cards.length == 3 && player2.cards.length == 3
      open_all_cards
    else
      player_selection
    end 
  end

  def skip_player_turn(player)
    if player == player1
      @skip_turn = false
      player2_turn
    else
      player_selection
    end
  end

  def open_all_cards
    @show = true
    show_points
    winner
  end

  def player2_turn
    if @more_cards_player2 && player2.points < 17
      @more_cards_player2 = false
      one_more_card(player2)
    else
      skip_player_turn(player2)
    end
  end

  def winner
    # if player1.points == player2.points
    #   puts "Ничья!"
    if (player1.points > player2.points || player2.points > 21) && player1.points <= 21
      puts "Победил #{player1.name}!"
    elsif (player2.points > player1.points || player1.points > 21) && player2.points <= 21
      puts "Победил #{player2.name}!"
    else
      puts "Ничья!"
    end
    self.game.give_bank(player1, player2)
    puts "Баланс #{player1.name} - #{player1.balance}. " \
    "Баланс #{player2.name} - #{player2.balance}."
    puts "====================================================================="
    if player1.balance == 0
      puts "Игрок #{player2.name} Победил"
      start_over
    elsif player2.balance == 0
      puts "Игрок #{player1.name} Победил"
      start_over
    else
      new_game
    end
  end

  def new_game
    @show = false
    @skip_turn = true
    @more_cards_player1 = true
    @more_cards_player2 = true
    @open_cards = true
    @cards = Cards.new
    player1.zeroing_cards
    player2.zeroing_cards
    deal
  end

  def show_cards(player)
    self.cards_picture = []
    player.cards.each_key { |key| self.cards_picture << key }
  end

  def show_points
    show_cards(player1)
    puts "Карты игрока #{player1.name}: #{cards_picture}. Количество очков: #{player1.points}"
    cards_amount = player2.cards.length
    if @show
      show_cards(player2)
      puts "Карты игрока #{player2.name}: #{cards_picture}. Количество очков: #{player2.points}"
    else
      puts "Карты игрока #{player2.name}: ***"
    end
  end

  def greeting
    'Приветствую в игре Black Jack Ruby'
  end

  def start_over
    puts "Нажмите 1, что бы начать заново"
    puts "Нажмите что угодно, что бы выйти"
    answer = gets.chomp
    case answer
    when "1"
      new_game
      create_game
    else
       exit
    end
  end

end

main = Main.new
main.create_game
