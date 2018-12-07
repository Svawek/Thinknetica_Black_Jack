require_relative 'cards'
require_relative 'player'
require_relative 'game'
require 'byebug'

# Class manage interface
class Main
  SELECTIONS = /^[mMoOsS]$/.freeze

  attr_reader :player1, :player2, :cards, :game, :show, :skip_turn
  attr_reader :more_cards_player1, :more_cards_player2, :open_cards, :cards_picture
  def initialize
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
    @player1 = Player.new(name)
    @player2 = Player.new('Компьютер')
    @cards = Cards.new
    @game = Game.new
    deal
  end

  def deal
    cards.cards_interfere
    game.bet(player1, player2)
    # 2.times do
    (1..2).each do |_i|
      game.give_card(player1, cards)
      game.give_card(player2, cards)
    end
    player1.count_points
    player2.count_points
    show_points
    player_selection
  end

  def player_selection
    puts 'Нажмите M, что бы взять еще одну карту' if @more_cards_player1
    puts 'Нажмите S, что бы пропустить ход' if @skip_turn
    puts 'Нажмите O, что бы открыть карты' if @open_cards
    answer = gets.chomp
    valid(answer)
    case answer
    when 'M', 'm'
      one_more_card(player1)
    when 'S', 's'
      skip_player_turn(player1)
    when 'O', 'o'
      open_all_cards
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def greeting
    'Приветствую в игре Black Jack Ruby'
  end

  private

  attr_writer :player1, :player2, :cards, :game, :show, :skip_turn
  attr_writer :more_cards_player1, :more_cards_player2, :open_cards, :cards_picture

  def valid(choise)
    raise 'Не правильный выбор' unless choise =~ SELECTIONS
  end

  def one_more_card(player)
    game.give_card(player, cards)
    player.count_points
    if player == player1
      self.more_cards_player1 = false
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
      self.skip_turn = false
      player2_turn
    else
      player_selection
    end
  end

  def open_all_cards
    self.show = true
    show_points
    winner
  end

  def player2_turn
    if @more_cards_player2 && player2.points < 17
      self.more_cards_player2 = false
      one_more_card(player2)
    else
      skip_player_turn(player2)
    end
  end

  def new_game
    self.show = false
    self.skip_turn = true
    self.more_cards_player1 = true
    self.more_cards_player2 = true
    self.open_cards = true
    self.cards = Cards.new
    player1.zeroing_cards
    player2.zeroing_cards
    deal
  end

  def show_cards(player)
    self.cards_picture = []
    player.cards.each_key { |key| cards_picture << key }
  end

  def show_points
    show_cards(player1)
    puts "Карты игрока #{player1.name}: #{cards_picture}. Количество очков: #{player1.points}"
    if @show
      show_cards(player2)
      puts "Карты игрока #{player2.name}: #{cards_picture}. Количество очков: #{player2.points}"
    else
      puts "Карты игрока #{player2.name}: ***"
    end
  end

  def winner
    if (player1.points > player2.points || player2.points > 21) && player1.points <= 21
      puts "Победил #{player1.name}!"
    elsif (player2.points > player1.points || player1.points > 21) && player2.points <= 21
      puts "Победил #{player2.name}!"
    else
      puts 'Ничья!'
    end
    game.give_bank(player1, player2)
    puts "Баланс #{player1.name} - #{player1.balance}. " \
    "Баланс #{player2.name} - #{player2.balance}."
    puts '====================================================================='
    if player1.balance.zero?
      puts "Игрок #{player2.name} Победил"
      start_over
    elsif player2.balance.zero?
      puts "Игрок #{player1.name} Победил"
      start_over
    else
      new_game
    end
  end

  def start_over
    puts 'Нажмите 1, что бы начать заново'
    puts 'Нажмите что угодно, что бы выйти'
    answer = gets.chomp
    case answer
    when '1'
      new_game
      create_game
    else
      exit
    end
  end
end

main = Main.new
main.create_game
