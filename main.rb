require_relative 'card'
require_relative 'player'
require_relative 'game'
require_relative 'interface'
require_relative 'hand'
require_relative 'deck'
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
    @interface = Interface.new
  end

  def create_game
    @interface.greeting
    @interface.player_name
    name = @interface.receive_answer
    @player1 = Player.new(name)
    player1.hand << Hand.new
    @player2 = Player.new('Компьютер')
    player2.hand << Hand.new
    @cards = Deck.new
    @game = Game.new
    deal
  end

  def deal
    cards.cards_interfere
    game.bet(player1, player2)
    (1..2).each do |_i|
      game.give_card(player1, cards)
      game.give_card(player2, cards)
    end
    show_points
    player_selection
  end

  def player_selection
    @interface.more_cards if @more_cards_player1
    @interface.skip_turn if @skip_turn
    @interface.open_cards if @open_cards
    answer = @interface.receive_answer
    valid(answer)
    @interface.menu_item_selection(self, player1, answer)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def one_more_card(player)
    game.give_card(player, cards)
    if player == player1
      self.more_cards_player1 = false
      show_points
      player2_turn
    elsif player1.hand[0].cards.length == 3 && player2.hand[0].cards.length == 3
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

  def start_over
    @interface.start_over_ask
    answer = @interface.receive_answer
    @interface.start_over_choise(self, answer)
  end

  def new_game
    default_value
    self.cards = Deck.new
    player1.hand[0].zeroing_cards
    player2.hand[0].zeroing_cards
    deal
  end

  def default_value
    self.show = false
    self.skip_turn = true
    self.more_cards_player1 = true
    self.more_cards_player2 = true
    self.open_cards = true
  end

  private

  attr_writer :player1, :player2, :cards, :game, :show, :skip_turn
  attr_writer :more_cards_player1, :more_cards_player2, :open_cards, :cards_picture

  def valid(choise)
    raise 'Не правильный выбор' unless choise =~ SELECTIONS
  end

  def player2_turn
    if @more_cards_player2 && player2.hand[0].points < 17
      self.more_cards_player2 = false
      one_more_card(player2)
    else
      skip_player_turn(player2)
    end
  end

  def show_points
    @interface.show_cards_points(player1)
    if @show
      @interface.show_cards_points(player2)
    else
      @interface.show_computer_cards(player2)
    end
  end

  def winner
    points_p1 = player1.hand[0].points
    points_p2 = player2.hand[0].points
    if (points_p1 > points_p2 || points_p2 > 21) && points_p1 <= 21
      @interface.winner(player1)
    elsif (points_p2 > points_p1 || points_p1 > 21) && points_p2 <= 21
      @interface.winner(player2)
    else
      @interface.draw
    end
    game.give_bank(player1, player2)
    @interface.show_balance(player1, player2)
    @interface.show_separator
    game_over
  end

  def game_over
    if player1.balance.zero?
      @interface.show_winner_game(player2)
      start_over
    elsif player2.balance.zero?
      @interface.show_winner_game(player1)
      start_over
    else
      new_game
    end
  end
end

main = Main.new
main.create_game
