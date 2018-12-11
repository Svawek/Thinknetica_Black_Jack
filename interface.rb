# Class manage game's interface (puts and gets)
class Interface
  def greeting
    puts 'Приветствую в игре Black Jack Ruby'
  end

  def player_name
    puts 'Введите Ваше имя:'
  end

  def receive_answer
    gets.chomp
  end

  def more_cards
    puts 'Нажмите M, что бы взять еще одну карту'
  end

  def skip_turn
    puts 'Нажмите S, что бы пропустить ход'
  end

  def open_cards
    puts 'Нажмите O, что бы открыть карты'
  end

  def menu_item_selection(location, player, answer)
    case answer
    when 'M', 'm'
      location.one_more_card(player)
    when 'S', 's'
      location.skip_player_turn(player)
    when 'O', 'o'
      location.open_all_cards
    end
  end

  def show_cards_points(player)
    puts "Карты игрока #{player.name}: #{show_cards(player.hand[0])}. " \
    "Количество очков: #{player.hand[0].points}"
  end

  def show_cards(hand)
    cards = []
    hand.cards.each do |card|
      cards << card.value + card.suit
    end
    print cards.join(' ')
  end

  def show_computer_cards(player)
    puts "Карты игрока #{player.name}: ***"
  end

  def winner(player)
    puts "Победил #{player.name}!"
  end

  def draw
    puts 'Ничья!'
  end

  def show_balance(player1, player2)
    puts "Баланс #{player1.name} - #{player1.balance}. " \
    "Баланс #{player2.name} - #{player2.balance}."
  end

  def show_separator
    puts '====================================================================='
  end

  def show_winner_game(player)
    puts "Игрок #{player.name} Победил"
  end

  def start_over_ask
    puts 'Нажмите 1, что бы начать заново'
    puts 'Нажмите что угодно, что бы выйти'
  end

  def start_over_choise(location, answer)
    case answer
    when '1'
      location.default_value
      location.create_game
    else
      exit
    end
  end
end
