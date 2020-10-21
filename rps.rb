class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def wins!
    puts "#{name} won!"
    @score += 1
  end

  def reset!
    @score = 0
    @move = nil
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
    end
    self.name = n
  end

  def choose
    choice = ''
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if RPSGame::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = RPSGame::VALUES[choice]
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = RPSGame::VALUES[RPSGame::VALUES.keys.sample]
  end
end

class Move
  attr_reader :value, :beats

  def >(other)
    beats.include?(other.value)
  end

  def <(other)
    other.beats.include?(value)
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @beats = ['scissors', 'lizard']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = ['rock', 'spock']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = ['paper', 'lizard']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = ['paper', 'spock']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = ['rock', 'scissors']
  end
end

class RPSGame
  attr_accessor :human, :computer

  WINNING_SCORE = 3
  VALUES = { 'rock' => Rock.new,
             'paper' => Paper.new,
             'scissors' => Scissors.new,
             'lizard' => Lizard.new,
             'spock' => Spock.new }

  def initialize
    @human = Human.new
    @computer = Computer.new
    @winner = false
  end

  def display_welcome_message
    puts "Greetings, #{human.name}!\nWelcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye, #{human.name}!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      human.wins!
    elsif human.move < computer.move
      computer.wins!
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n."
    end
    display_goodbye_message if answer == 'y'
    answer == 'y'
  end

  def display_score
    puts "Current score is\n     #{human.name}: "\
    "#{human.score}, #{computer.name}: #{computer.score}"
  end

  def check_winner
    if human.score == WINNING_SCORE
      puts "#{human.name} wins the match!"
      @winner = true
    elsif computer.score == WINNING_SCORE
      puts "#{computer.name} wins the match!"
      @winner = true
    end
  end

  def finish_game
    display_moves
    display_winner
    display_score
    check_winner
  end

  def play
    display_welcome_message

    loop do
      loop do
        human.choose
        computer.choose
        finish_game
        break if @winner
      end
      break unless play_again?
    end
  end
end

RPSGame.new.play
