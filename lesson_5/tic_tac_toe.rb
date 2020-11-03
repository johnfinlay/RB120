require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def full?
    unmarked_keys.empty?
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def get_hint(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      markers = squares.select(&:marked?).collect(&:marker)
      # binding.pry
      if markers.size == 2 && markers.all?(marker)
        return line[squares.collect(&:marker).index(' ')]
      end
    end
    nil
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    markers.size == 3 && markers.all?(markers.first)
  end
end

class Square
  attr_accessor :marker

  INITIAL_MARKER = ' '

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def unmarked?
    @marker == INITIAL_MARKER
  end

  def marked?
    @marker != INITIAL_MARKER
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = 'human'
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = FIRST_TO_MOVE
  end

  private

  def display_welcome_message
    puts "Welcom to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(arr, delimiter = ', ', last_delimiter = 'or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{last_delimiter} ")
    else
      arr[-1] = "#{last_delimiter} #{arr.last}"
      arr.join(delimiter)
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys, ', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def best_choice
    choice = board.get_hint(computer.marker)
    choice = board.get_hint(human.marker) unless !!choice
    choice = board.unmarked_keys.sample unless !!choice
    choice
  end

  def computer_moves
    board[best_choice] = computer.marker
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
      human.score += 1
    when computer.marker
      puts "Computer won!"
      computer.score += 1
    else puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset_game
    board.reset
    @current_player = FIRST_TO_MOVE
    clear
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def next_player
    @current_player = human_turn? ? 'computer' : 'human'
  end

  def current_player_moves
    human_turn? ? human_moves : computer_moves
    next_player
  end

  def display_score
    puts "The score is you: #{human.score}, computer: #{computer.score}"
    puts "You win the match!" if human.score == 5
    puts "Computer wins the match!" if computer.score == 5
    puts "Press Enter to continue."
    gets.chomp
  end

  def human_turn?
    @current_player == 'human'
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def play_match
    loop do
      main_game
      break unless play_again?
      reset_game
      reset_scores
      display_play_again_message
    end
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      display_score
      break if human.score == 5 || computer.score == 5
      reset_game
    end
  end

  public

  def play
    clear
    display_welcome_message
    play_match
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
