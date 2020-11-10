class Player < Participant
  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end
end

class Dealer < Participant
  def initialize
    # seems like very similar to Player... do we even need this?
  end

  def deal
    # does the dealer or the deck deal?
  end
end

module Hand
  def hit
  end

  def stay
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Participant
  include Hand
end

class Deck
  def initialize
    # obviously, we need some data structure to keep track of cards
    # array, hash, something else?
  end

  def deal
    # does the dealer or the deck deal?
  end
end

class Card
  def initialize
    # what are the "states" of a card?
  end
end

class Game
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start
