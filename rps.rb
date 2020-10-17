=begin
  Rock, Paper, Scissors is a two-player game where each player chooses
  one of three possible moves: rock, paper, or scissors. The chosen moves
  will then be compared to see who wins, according to the following rules:

  - rock beats scissors
  - scissors beats paper
  - paper beats rock

  If the players chose the same move, then it's a tie.

  Nouns: player, move, rule
  Verbs: choose, compare

  Player
  - choose
  Move
  Rule

  - compare

=end

class Player
  def initialize
  end

  def choose

  end
end

class Move
  def initialize
  end
end

class Rule
  def initialize
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

def compare(move1, move2)

end

RPSGame.new.play
